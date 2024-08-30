return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'latex' },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            opts.servers.texlab = {}
        end,
    },
}
