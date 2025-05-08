return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { languages = { 'latex' } },
    },
    {
        'mason-org/mason.nvim',
        opts = function(_, opts)
            if not vim.g.android then
                opts.install[#opts.install + 1] = 'texlab'
            end
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            if not vim.g.android then
                opts.servers.texlab = {}
            end
        end,
    },
}
