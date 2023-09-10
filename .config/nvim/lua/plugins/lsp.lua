return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        -- LSP Support
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'L3MON4D3/LuaSnip',
    },
    config = function()
        local lsp_zero = require('lsp-zero')
        lsp_zero.on_attach(function(client, bufnr)
            lsp_zero.default_keymaps({buffer = bufnr})
        end)

        require('mason').setup({})
        require('mason-lspconfig').setup({
            -- Servers: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
            ensure_installed = {
                'bashls', -- Bash
                'eslint', -- ESLint
                'gopls', -- Go
                'jdtls', -- Java
                'jsonls', -- JSON
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
            },
        })

        local cmp = require('cmp')
        cmp.setup({
            mapping = {
                ['<CR>'] = cmp.mapping.confirm({select = true}),
            },
        })
     end,
}
