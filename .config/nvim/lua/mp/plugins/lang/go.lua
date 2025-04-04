return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'go', 'gomod', 'gosum', 'gowork' },
        },
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            opts.install[#opts.install + 1] = 'gopls'
            vim.list_extend(opts.install, { 'goimports', 'gofumpt' })
            opts.formatters.go = { 'goimports', 'gofumpt' }
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            opts.servers.gopls = {}
        end,
    },
}
