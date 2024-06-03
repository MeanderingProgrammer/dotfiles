return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            vim.list_extend(opts.languages, { 'go' })
            vim.list_extend(opts.languages, { 'gomod', 'gosum', 'gowork' })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            opts.servers.gopls = {}
        end,
    },
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                go = { 'goimports', 'gofumpt' },
            },
        },
    },
}
