return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { languages = { 'latex' } },
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            if not vim.g.android then
                table.insert(opts.install, 'texlab')
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
