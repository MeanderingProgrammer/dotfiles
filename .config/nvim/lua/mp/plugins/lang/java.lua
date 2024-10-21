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
            local root_files = { '.git', 'gradlew', 'build.gradle', 'mvnw', 'pom.xml' }

            ---@return string?
            local function get_platform()
                if vim.fn.has('mac') == 1 then
                    return 'mac'
                elseif vim.fn.has('unix') == 1 or vim.fn.has('wsl') == 1 then
                    return 'linux'
                else
                    print('Unsupported system')
                end
            end

            local function jdtls_setup()
                local jdtls = require('jdtls')

                local jdtls_install = require('mason-registry').get_package('jdtls'):get_install_path()

                local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

                jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

                local capabilities = vim.tbl_deep_extend(
                    'force',
                    vim.lsp.protocol.make_client_capabilities(),
                    require('cmp_nvim_lsp').default_capabilities()
                )

                -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
                local cmd = {
                    'java',
                    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                    '-Dosgi.bundles.defaultStartLevel=4',
                    '-Declipse.product=org.eclipse.jdt.ls.core.product',
                    '-Dlog.protocol=true',
                    '-Dlog.level=ALL',
                    '-javaagent:' .. jdtls_install .. '/lombok.jar',
                    '-Xms2g',
                    '--add-modules=ALL-SYSTEM',
                    '--add-opens',
                    'java.base/java.util=ALL-UNNAMED',
                    '--add-opens',
                    'java.base/java.lang=ALL-UNNAMED',
                    '-jar',
                    vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
                    '-configuration',
                    jdtls_install .. '/config_' .. get_platform(),
                    '-data',
                    vim.fn.stdpath('cache') .. '/nvim-jdtls/' .. project_name,
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
                    },
                    contentProvider = { preferred = 'fernflower' },
                    extendedClientCapabilities = jdtls.extendedClientCapabilities,
                    codeGeneration = {
                        toString = {
                            template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
                        },
                        useBlocks = true,
                    },
                }

                jdtls.start_or_attach({
                    cmd = cmd,
                    settings = lsp_settings,
                    capabilities = capabilities,
                    root_dir = jdtls.setup.find_root(root_files),
                    flags = { allow_incremental_sync = true },
                    init_options = { bundles = {} },
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
