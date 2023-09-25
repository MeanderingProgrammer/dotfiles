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
            vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', {
                buffer = bufnr,
                desc = 'Telescope: Goto Definitions',
            })
            vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {
                buffer = bufnr,
                desc = 'Telescope: Goto References',
            })
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
                bashls = require('plugins.lsp.bash').setup,
                lua_ls = require('plugins.lsp.lua').setup,
                gradle_ls = require('plugins.lsp.gradle').setup,
                efm = require('plugins.lsp.efm').setup,
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

        require('plugins.lsp.efm').update_on_write()
    end,
}
