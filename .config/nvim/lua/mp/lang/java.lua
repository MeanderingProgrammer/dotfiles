local utils = require('mp.lib.utils')

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
            root_markers = {
                'settings.gradle',
                'settings.gradle.kts',
                'build.gradle',
                'build.gradle.kts',
                'pom.xml',
                'build.xml',
                '.git',
            },
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
            override = function(config)
                -- https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
                local cmd = { 'jdtls' } ---@type string[]

                local jdtls = vim.fs.joinpath(vim.env.MASON, 'share', 'jdtls')
                local lombok = vim.fs.joinpath(jdtls, 'lombok.jar')
                vim.list_extend(cmd, {
                    '--jvm-arg=-Dlog.level=ALL',
                    '--jvm-arg=-Dlog.protocol=true',
                    '--jvm-arg=-javaagent:' .. lombok,
                })

                local project = vim.fs.basename(vim.fn.getcwd())
                local cache = utils.path('cache', 'jdtls', project)
                vim.list_extend(cmd, {
                    '-configuration',
                    vim.fs.joinpath(cache, 'config'),
                    '-data',
                    vim.fs.joinpath(cache, 'workspace'),
                })

                config.cmd = cmd
            end,
        },
    },
})
