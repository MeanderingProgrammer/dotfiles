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
                bashls = require('mp.plugins.lsp.bash').setup,
                lua_ls = require('mp.plugins.lsp.lua').setup,
                gradle_ls = require('mp.plugins.lsp.gradle').setup,
            },
        })

        local cmp = require('cmp')
        ---@diagnostic disable-next-line: missing-fields
        cmp.setup({
            ---@diagnostic disable-next-line: missing-fields
            completion = {
                keyword_length = 3,
            },
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
            sources = {
                { name = 'buffer' },
            },
        })

        ---@diagnostic disable-next-line: missing-fields
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
        })
    end,
}
