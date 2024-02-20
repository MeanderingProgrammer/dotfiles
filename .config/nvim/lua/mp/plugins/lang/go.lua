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
