return {
    'mfussenegger/nvim-jdtls',
    config = function()
        local root_files = { '.git', 'gradlew' }
        local function get_platform()
            if vim.fn.has('mac') == 1 then
                return 'mac'
            elseif vim.fn.has('wsl') == 1 then
                return 'linux'
            else
                print('Unsupported system')
            end
        end
        local function setup()
            local jdtls = require('jdtls')

            local jdtls_install = require('mason-registry').get_package('jdtls'):get_install_path()
            local data_dir = vim.fn.stdpath('cache') .. '/nvim-jdtls/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

            local extendedClientCapabilities = jdtls.extendedClientCapabilities
            extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

            local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
            local capabilities = vim.tbl_deep_extend(
                'force',
                vim.lsp.protocol.make_client_capabilities(),
                ok_cmp and cmp_lsp.default_capabilities() or {}
            )

            local config = {
                cmd = {
                    'java',
                    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                    '-Dosgi.bundles.defaultStartLevel=4',
                    '-Declipse.product=org.eclipse.jdt.ls.core.product',
                    '-Dlog.protocol=true',
                    '-Dlog.level=ALL',
                    '-javaagent:' .. jdtls_install .. '/lombok.jar',
                    '-Xms1g',
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
                    data_dir,
                },
                settings = {
                    java = {
                        eclipse = { downloadSources = true },
                        configuration = { updateBuildConfiguration = 'interactive' },
                        maven = { downloadSources = true },
                        implementationsCodeLens = { enabled = true },
                        referencesCodeLens = { enabled = true },
                        format = { enabled = true },
                        saveActions = { organizeImports = true },
                    },
                    signatureHelp = { enabled = true },
                    contentProvider = { preferred = 'fernflower' },
                    extendedClientCapabilities = extendedClientCapabilities,
                    sources = {
                        organizeImports = {
                            starThreshold = 9999,
                            staticStarThreshold = 9999,
                        },
                    },
                    codeGeneration = {
                        toString = {
                            template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
                        },
                        useBlocks = true,
                    },
                },
                capabilities = capabilities,
                root_dir = jdtls.setup.find_root(root_files),
                flags = { allow_incremental_sync = true },
                init_options = { bundles = {} },
            }

            jdtls.start_or_attach(config)
        end
        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('JavaCmds', { clear = true }),
            pattern = { 'java' },
            desc = 'Setup jdtls',
            callback = setup,
        })
    end,
}
