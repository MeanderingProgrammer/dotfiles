return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = false,
    dependencies = {
        -- Lua LSP Improvement
        'folke/neodev.nvim',
        -- LSP Support
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'L3MON4D3/LuaSnip',
        -- Formatting / Linting
        'creativenull/efmls-configs-nvim',
        -- Additional Sources
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
    },
    config = function()
        require('neodev').setup({})

        local lsp_zero = require('lsp-zero')
        lsp_zero.on_attach(function(_, bufnr)
            lsp_zero.default_keymaps({ buffer = bufnr })
        end)

        require('mason').setup({})
        require('mason-lspconfig').setup({
            -- Servers: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
            ensure_installed = {
                'bashls', -- Bash
                'efm', -- EFM (formatting / linting)
                'eslint', -- ESLint
                'gopls', -- Go
                'gradle_ls', -- Gradle
                'jdtls', -- Java
                'jsonls', -- JSON
                'kotlin_language_server', -- Kotlin
                'lua_ls', -- Lua
                'marksman', -- Markdown
                'pyright', -- Python
                'rust_analyzer', -- Rust
                'svelte', -- Svelte
                'tailwindcss', --Tailwind
                'terraformls', --Terraform
                'tsserver', -- TypeScript
            },
            handlers = {
                lsp_zero.default_setup,
                bashls = function()
                    require('lspconfig').bashls.setup({
                        filetypes = { 'sh', 'zsh' },
                    })
                end,
                lua_ls = function()
                    local lua_settings = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    }
                    require('lspconfig').lua_ls.setup({
                        settings = { Lua = lua_settings },
                    })
                end,
                gradle_ls = function()
                    require('lspconfig').gradle_ls.setup({
                        filetypes = { 'kotlin', 'groovy' },
                    })
                end,
                efm = function()
                    local languages = {
                        go = { require('efmls-configs.formatters.gofmt') },
                        lua = { require('efmls-configs.formatters.stylua') },
                        rust = { require('efmls-configs.formatters.rustfmt') },
                    }
                    require('lspconfig').efm.setup({
                        filetypes = vim.tbl_keys(languages),
                        settings = {
                            rootMarkers = { '.git/' },
                            languages = languages,
                        },
                        init_options = {
                            documentFormatting = true,
                            documentRangeFormatting = true,
                        },
                    })
                end
            },
        })

        local cmp = require('cmp')
        cmp.setup({
            sources = {
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
            },
            mapping = {
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            },
        })

        local lsp_fmt_group = vim.api.nvim_create_augroup('LspFormattingGroup', {})
        vim.api.nvim_create_autocmd('BufWritePost', {
            group = lsp_fmt_group,
            callback = function()
                local efm = vim.lsp.get_active_clients({ name = 'efm' })
                if vim.tbl_isempty(efm) then
                    return
                end
                vim.lsp.buf.format({ name = 'efm' })
            end,
        })
     end,
}
