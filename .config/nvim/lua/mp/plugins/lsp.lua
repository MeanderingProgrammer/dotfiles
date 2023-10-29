return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        -- Use Telescope for keymaps
        'nvim-telescope/telescope.nvim',
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
        -- Additional Sources
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-path',
    },
    config = function()
        require('neodev').setup({})

        local lsp_zero = require('lsp-zero')
        lsp_zero.on_attach(function(_, bufnr)
            lsp_zero.default_keymaps({ buffer = bufnr })
            local function map(lhs, f, opts, desc)
                local function rhs()
                    f(opts)
                end
                vim.keymap.set('n', lhs, rhs, { buffer = bufnr, desc = 'LSP: ' .. desc })
            end
            local builtin = require('telescope.builtin')
            map('gd', builtin.lsp_definitions, { jump_type = 'never' }, 'Goto Definitions')
            map('gr', builtin.lsp_references, { jump_type = 'never' }, 'Goto References')
        end)

        require('mason').setup({})
        require('mason-lspconfig').setup({
            -- Servers: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
            ensure_installed = {
                'bashls', -- Bash
                'eslint', -- ESLint
                'gopls', -- Go
                'gradle_ls', -- Gradle
                'jdtls', -- Java
                'jsonls', -- JSON
                'kotlin_language_server', -- Kotlin
                'lua_ls', -- Lua
                'marksman', -- Markdown
                'ocamllsp', -- OCaml
                'pyright', -- Python
                'rust_analyzer', -- Rust
                'svelte', -- Svelte
                'tailwindcss', -- Tailwind
                'terraformls', -- Terraform
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
                    require('lspconfig').lua_ls.setup({
                        settings = {
                            Lua = {
                                workspace = { checkThirdParty = false },
                                telemetry = { enable = false },
                            },
                        },
                    })
                end,
                gradle_ls = function()
                    require('lspconfig').gradle_ls.setup({
                        filetypes = { 'kotlin', 'groovy' },
                    })
                end,
            },
        })

        local cmp = require('cmp')
        ---@diagnostic disable-next-line: missing-fields
        cmp.setup({
            sources = {
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
            },
            mapping = {
                ['<cr>'] = cmp.mapping.confirm({ select = true }),
                ['<C-space>'] = cmp.mapping.complete(),
            },
        })

        ---@diagnostic disable-next-line: missing-fields
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = { { name = 'buffer' } },
        })

        ---@diagnostic disable-next-line: missing-fields
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
        })
    end,
}
