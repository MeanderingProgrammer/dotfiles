return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'go', 'gomod', 'gosum', 'gowork' },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            opts.servers.gopls = {}
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = {
            formatters = {
                go = { 'goimports', 'gofumpt' },
            },
        },
    },
}
