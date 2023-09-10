return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
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
        local lsp = require('lsp-zero').preset({})
        lsp.on_attach(function(client, bufnr)
            lsp.default_keymaps({buffer = bufnr})
        end)
        lsp.ensure_installed({
            'tsserver', -- TypeScript
            'pyright', -- Python
            'rust_analyzer', -- Rust
            'jdtls', -- Java
            'svelte', -- Svelte
        })
        lsp.setup()

        local cmp = require('cmp')
        cmp.setup({
            mapping = {
                ['<CR>'] = cmp.mapping.confirm({select = true}),
            },
        })
     end,
}
