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
            opts.mason.gopls = {}
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            local formatters = { 'goimports', 'gofumpt' }
            vim.list_extend(opts.ensure_installed, formatters)
            opts.formatters.go = formatters
        end,
    },
}
