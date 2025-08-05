local utils = require('mp.utils')

---@class mp.rust.Runnable
---@field kind 'cargo'|'shell'
---@field args { cwd: string, cargoArgs: string[] }

---@class mp.rust.Build
---@field cwd string
---@field cmd string[]

---@class mp.rust.Artifact
---@field executable? string

local function dap_program()
    local client, items = utils.lsp_request('experimental/runnables', {
        textDocument = vim.lsp.util.make_text_document_params(),
    })
    if not client or not items then
        return nil
    end

    local runnables = items ---@type mp.rust.Runnable[]
    local builds = {} ---@type mp.rust.Build[]
    for _, runnable in ipairs(runnables) do
        if runnable.kind == 'cargo' then
            local args = runnable.args
            if args.cargoArgs[1] == 'run' then
                args.cargoArgs[1] = 'build'
            end
            if args.cargoArgs[1] == 'build' then
                builds[#builds + 1] = {
                    cwd = args.cwd,
                    cmd = vim.list_extend({ 'cargo' }, args.cargoArgs),
                }
            end
        end
    end
    if #builds == 0 then
        builds[#builds + 1] = {
            cwd = client.workspace_folders[1].name,
            cmd = { 'cargo', 'build' },
        }
    end

    ---@param build? mp.rust.Build
    ---@return string?
    local function debug(build)
        if not build then
            return nil
        end

        local cmd = vim.list_extend(build.cmd, { '--message-format=json' })
        local result = vim.system(cmd, { cwd = build.cwd, text = true }):wait()
        local output = result.stdout
        if not output then
            return nil
        end

        local executables = {} ---@type string[]
        local values = utils.split(output, '\n')
        for _, value in ipairs(values) do
            ---@type boolean, mp.rust.Artifact?
            local ok, artifact = pcall(vim.fn.json_decode, value)
            if ok and artifact then
                local executable = artifact.executable
                if executable and executable ~= vim.NIL then
                    executables[#executables + 1] = executable
                end
            end
        end
        return #executables == 1 and executables[1] or nil
    end

    return coroutine.create(function(dap_run_co)
        vim.ui.select(builds, {
            prompt = 'Builds',
            ---@param build mp.rust.Build
            ---@return string
            format_item = function(build)
                return table.concat(build.cmd, ' ')
            end,
        }, function(build)
            coroutine.resume(dap_run_co, debug(build))
        end)
    end)
end

require('mp.lang').add({
    parser = {
        rust = { install = true },
        toml = { install = true },
    },
    tool = {
        ['rust-analyzer'] = { install = vim.g.pc },
        ['codelldb'] = { install = vim.g.pc },
        ['taplo'] = { install = vim.g.pc },
    },
    lsp = {
        rust_analyzer = {
            settings = {
                ['rust-analyzer'] = {
                    check = { command = 'clippy' },
                    diagnostics = { disabled = { 'inactive-code' } },
                },
            },
        },
    },
    dap = {
        adapters = {
            codelldb = {
                type = 'executable',
                command = 'codelldb',
                args = {},
            },
        },
        configurations = {
            rust = {
                {
                    name = 'Launch file',
                    type = 'codelldb',
                    request = 'launch',
                    program = dap_program,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                },
            },
        },
    },
    format = {
        taplo = { filetypes = { 'toml' } },
    },
})
