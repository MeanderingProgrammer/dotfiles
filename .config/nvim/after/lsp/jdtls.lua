local utils = require('mp.lib.utils')

---@param config vim.lsp.ClientConfig
---@param kind 'config'|'workspace'
---@return string
local function path(config, kind)
    local project = vim.fs.basename(assert(config.root_dir))
    return utils.path('cache', 'jdtls', project, kind)
end

---@type vim.lsp.Config
return {
    -- https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = function(dispatchers, config)
        local cmd = { 'jdtls' } ---@type string[]

        local jdtls = vim.fs.joinpath(vim.env.MASON, 'share', 'jdtls')
        local lombok = vim.fs.joinpath(jdtls, 'lombok.jar')
        vim.list_extend(cmd, {
            '--jvm-arg=-Dlog.level=ALL',
            '--jvm-arg=-Dlog.protocol=true',
            '--jvm-arg=-javaagent:' .. lombok,
        })

        vim.list_extend(cmd, {
            '-configuration',
            path(config, 'config'),
            '-data',
            path(config, 'workspace'),
        })

        return vim.lsp.rpc.start(cmd, dispatchers, {
            cwd = config.cmd_cwd,
            env = config.cmd_env,
            detached = config.detached,
        })
    end,
    -- https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line
    settings = {
        java = {
            codeGeneration = {
                toString = {
                    template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
                },
                useBlocks = true,
            },
            contentProvider = { preferred = 'fernflower' },
            eclipse = { downloadSources = true },
            implementationsCodeLens = { enabled = true },
            maven = { downloadSources = true },
            referencesCodeLens = { enabled = true },
            saveActions = { organizeImports = true },
            signatureHelp = { enabled = true },
            sources = {
                organizeImports = {
                    starThreshold = 2,
                    staticStarThreshold = 2,
                },
            },
        },
    },
    on_attach = function(client, bufnr)
        -- nvim-jdtls does not work with function cmd
        vim.api.nvim_buf_create_user_command(
            bufnr,
            'JdtWipeDataAndRestart',
            function()
                local data = path(client.config, 'workspace')
                vim.ui.select(
                    { 'Yes', 'No' },
                    { prompt = ('Wipe "%s" and restart? '):format(data) },
                    function(item)
                        if item == 'Yes' then
                            vim.fs.rm(data, { recursive = true, force = true })
                            vim.cmd.JdtRestart()
                        end
                    end
                )
            end,
            {}
        )
    end,
}
