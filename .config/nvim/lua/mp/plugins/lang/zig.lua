return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'zig' },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            opts.servers.zls = {}
        end,
    },
}
