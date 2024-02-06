return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            local go_grammars = { 'go', 'gomod', 'gowork', 'gosum' }
            vim.list_extend(opts.ensure_installed, go_grammars)
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            servers = {
                gopls = {},
            },
        },
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
