local utils = require('mp.utils')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { languages = { 'java' } },
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            if not utils.is_android then
                table.insert(opts.install, 'jdtls')
            end
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            if not utils.is_android then
                opts.servers.jdtls = false
            end
        end,
    },
    {
        'mfussenegger/nvim-jdtls',
        enabled = not utils.is_android,
        config = function()
            local platform = nil
            if vim.fn.has('mac') == 1 then
                platform = 'mac'
            elseif vim.fn.has('unix') == 1 or vim.fn.has('wsl') == 1 then
                platform = 'linux'
            else
                vim.print('Java not supported on system')
                return
            end

            local function jdtls_setup()
                local jdtls = require('jdtls')

                local jdtls_path = require('mason-registry').get_package('jdtls'):get_install_path()

                local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

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
                    '-data', vim.fn.stdpath('cache') .. '/nvim-jdtls/' .. project_name,
                }

                -- https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line
                local lsp_settings = {
                    java = {
                        eclipse = { downloadSources = true },
                        configuration = { updateBuildConfiguration = 'interactive' },
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

                local capabilities = require('blink.cmp').get_lsp_capabilities()

                local extended_capabilities = jdtls.extendedClientCapabilities
                extended_capabilities.resolveAdditionalTextEditsSupport = true

                jdtls.start_or_attach({
                    cmd = cmd,
                    settings = lsp_settings,
                    capabilities = capabilities,
                    root_dir = vim.fs.root(0, { '.git', 'gradlew', 'build.gradle', 'mvnw', 'pom.xml' }),
                    flags = { allow_incremental_sync = true },
                    init_options = {
                        bundles = {},
                        extendedClientCapabilities = extended_capabilities,
                    },
                })
            end
            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup('JavaCmds', { clear = true }),
                pattern = { 'java' },
                desc = 'Setup jdtls',
                callback = jdtls_setup,
            })
        end,
    },
}
