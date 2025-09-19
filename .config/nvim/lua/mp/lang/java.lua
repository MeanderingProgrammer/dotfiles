---@return string[]
local function get_cmd()
    local project = vim.fs.basename(vim.fn.getcwd())
    local jdtls = vim.fs.joinpath(vim.env.MASON_HOME, 'share', 'jdtls')
    local cache = vim.fs.joinpath(vim.fn.stdpath('cache'), 'jdtls', project)

    -- https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    local cmd = { 'jdtls' } ---@type string[]

    vim.list_extend(cmd, {
        '--jvm-arg=-Dlog.level=ALL',
        '--jvm-arg=-Dlog.protocol=true',
        '--jvm-arg=-javaagent:' .. vim.fs.joinpath(jdtls, 'lombok.jar'),
    })

    vim.list_extend(cmd, {
        '-configuration',
        vim.fs.joinpath(cache, 'config'),
        '-data',
        vim.fs.joinpath(cache, 'workspace'),
    })

    return cmd
end

require('mp.lib.lang').add({
    parser = {
        java = { install = true },
        javadoc = { install = true },
    },
    tool = {
        ['jdtls'] = { install = true },
    },
    lsp = {
        jdtls = {
            cmd = get_cmd(),
            -- https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line
            settings = {
                java = {
                    eclipse = { downloadSources = true },
                    maven = { downloadSources = true },
                    implementationsCodeLens = { enabled = true },
                    referencesCodeLens = { enabled = true },
                    signatureHelp = { enabled = true },
                    saveActions = { organizeImports = true },
                    sources = {
                        organizeImports = {
                            starThreshold = 2,
                            staticStarThreshold = 2,
                        },
                    },
                    contentProvider = { preferred = 'fernflower' },
                    codeGeneration = {
                        toString = {
                            template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
                        },
                        useBlocks = true,
                    },
                },
            },
        },
    },
})
