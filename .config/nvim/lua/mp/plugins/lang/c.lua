return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'c', 'c_sharp', 'cmake', 'cpp', 'make' },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            opts.servers.clangd = {}
            opts.servers.csharp_ls = {}
        end,
    },
}
