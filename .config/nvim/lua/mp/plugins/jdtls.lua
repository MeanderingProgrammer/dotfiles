local function attach()
    local jdtls = require('jdtls')

    local jdtls_path = vim.fs.joinpath(vim.env.MASON, 'share', 'jdtls')
    local project = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

    local capabilities = jdtls.extendedClientCapabilities
    capabilities.resolveAdditionalTextEditsSupport = true

    jdtls.start_or_attach({
        -- https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
        -- stylua: ignore
        cmd = {
            'java',
            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dosgi.checkConfiguration=true',
            '-Dosgi.sharedConfiguration.area=' .. jdtls_path .. '/config',
            '-Dosgi.sharedConfiguration.area.readOnly=true',
            '-Dosgi.configuration.cascaded=true',
            '-Dlog.protocol=true',
            '-Dlog.level=ALL',
            '-Xms1G',
            '--add-modules=ALL-SYSTEM',
            '--add-opens', 'java.base/java.util=ALL-UNNAMED',
            '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
            '-javaagent:' .. jdtls_path .. '/lombok.jar',
            '-jar', jdtls_path .. '/plugins/org.eclipse.equinox.launcher.jar',
            '-data', vim.fn.stdpath('cache') .. '/nvim-jdtls/' .. project,
        },
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
        root_dir = vim.fs.root(0, {
            '.git',
            'build.gradle',
            'build.gradle.kts',
            'gradlew',
            'pom.xml',
            'mvnw',
        }),
        init_options = {
            extendedClientCapabilities = capabilities,
        },
    })
end

return {
    'mfussenegger/nvim-jdtls',
    dependencies = { 'mason-org/mason.nvim' },
    config = function()
        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('my.jdtls', {}),
            pattern = 'java',
            callback = attach,
        })
    end,
}
