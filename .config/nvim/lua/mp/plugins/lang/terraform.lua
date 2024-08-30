return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'terraform' },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            opts.servers.terraformls = {}
        end,
    },
}
