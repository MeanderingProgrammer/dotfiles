return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'go', 'gomod', 'gosum', 'gowork' },
        },
    },
    {
        'mason-org/mason.nvim',
        opts = {
            install = { 'gopls', 'goimports', 'gofumpt' },
            formatters = {
                go = { 'goimports', 'gofumpt' },
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            gopls = {},
        },
    },
}
