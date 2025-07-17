---@class mp.rust.Runnable
---@field kind 'cargo'|'shell'
---@field args { cwd: string, cargoArgs: string[] }

---@class mp.rust.Build
---@field cwd string
---@field cmd string[]

local function dap_program()
    local method = 'experimental/runnables'
    local client, items = require('mp.util').lsp.request(method, {
        textDocument = vim.lsp.util.make_text_document_params(),
    })
    if not client or not items then
        return nil
    end

    local builds = {} ---@type mp.rust.Build[]
    for _, item in ipairs(items) do
        local runnable = item ---@type mp.rust.Runnable
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
            return output
        end

        local executables = {} ---@type string[]
        local values = vim.split(output, '\n', { plain = true })
        for _, value in ipairs(values) do
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

return {
    {
        'nvim-treesitter/nvim-treesitter',
        ---@type mp.ts.Config
        opts = {
            rust = { install = true },
            toml = { install = true },
        },
    },
    {
        'mason-org/mason.nvim',
        ---@type mp.mason.Config
        opts = {
            ['rust-analyzer'] = { install = vim.g.pc },
            ['codelldb'] = { install = vim.g.pc },
            ['taplo'] = { install = vim.g.pc },
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            rust_analyzer = {
                settings = {
                    ['rust-analyzer'] = {
                        check = { command = 'clippy' },
                        diagnostics = { disabled = { 'inactive-code' } },
                    },
                },
            },
        },
    },
    {
        'mfussenegger/nvim-dap',
        ---@type mp.dap.Config
        opts = {
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
    },
    {
        'stevearc/conform.nvim',
        ---@type mp.conform.Config
        opts = {
            taplo = { filetypes = { 'toml' } },
        },
    },
    {
        'Saecki/crates.nvim',
        config = function()
            local crates = require('crates')
            crates.setup({
                lsp = {
                    enabled = true,
                    actions = true,
                    completion = true,
                    hover = true,
                },
            })

            ---@param lhs string
            ---@param rhs function
            ---@param desc string
            local function map(lhs, rhs, desc)
                vim.keymap.set('n', lhs, rhs, { desc = desc })
            end
            map('<leader>ct', crates.toggle, 'Toggle UI')
            map('<leader>cv', crates.show_versions_popup, 'Versions')
            map('<leader>cd', crates.show_dependencies_popup, 'Dependencies')
            map('<leader>cu', crates.upgrade_crate, 'Upgrade')
            map('<leader>cU', crates.upgrade_all_crates, 'Upgrade All')
        end,
    },
}
