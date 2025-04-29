return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { languages = { 'java' } },
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            if not vim.g.android then
                opts.install[#opts.install + 1] = 'jdtls'
            end
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            if not vim.g.android then
                opts.servers.jdtls = false
            end
        end,
    },
    {
        'mfussenegger/nvim-jdtls',
        enabled = not vim.g.android,
        config = function()
            local platform = nil
            if vim.g.mac then
                platform = 'mac'
            elseif vim.g.linux then
                platform = 'linux'
            else
                vim.print('Java not supported on system')
                return
            end

            local function jdtls_setup()
                local jdtls = require('jdtls')

                local jdtls_path = vim.fn.expand('$MASON/packages/jdtls')

                local project = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

                -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
                -- stylua: ignore
                local cmd = {
                    'java',
                    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                    '-Dosgi.bundles.defaultStartLevel=4',
                    '-Declipse.product=org.eclipse.jdt.ls.core.product',
                    '-Dlog.protocol=true',
                    '-Dlog.level=ALL',
                    '-Xms2g',
                    '-javaagent:' .. jdtls_path .. '/lombok.jar',
                    '--add-modules=ALL-SYSTEM',
                    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
                    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
                    '-jar', vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
                    '-configuration', jdtls_path .. '/config_' .. platform,
                    '-data', vim.fn.stdpath('cache') .. '/nvim-jdtls/' .. project,
                }

                -- https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line
                local lsp_settings = {
                    java = {
                        eclipse = { downloadSources = true },
                        configuration = {
                            updateBuildConfiguration = 'interactive',
                        },
                        maven = { downloadSources = true },
                        implementationsCodeLens = { enabled = true },
                        referencesCodeLens = { enabled = true },
                        signatureHelp = { enabled = true },
                        format = { enabled = true },
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
                }

                local capabilities = require('mp.utils').capabilities()

                local markers = {
                    '.git',
                    'build.gradle',
                    'gradlew',
                    'mvnw',
                    'pom.xml',
                }

                local extended_capabilities = jdtls.extendedClientCapabilities
                extended_capabilities.resolveAdditionalTextEditsSupport = true

                jdtls.start_or_attach({
                    cmd = cmd,
                    settings = lsp_settings,
                    capabilities = capabilities,
                    root_dir = vim.fs.root(0, markers),
                    flags = { allow_incremental_sync = true },
                    init_options = {
                        bundles = {},
                        extendedClientCapabilities = extended_capabilities,
                    },
                })
            end
            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup('JavaCmds', {}),
                pattern = { 'java' },
                desc = 'Setup jdtls',
                callback = jdtls_setup,
            })
        end,
    },
}
