return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { languages = { 'c', 'c_sharp', 'cmake', 'cpp', 'make' } },
    },
    {
        'mason-org/mason.nvim',
        opts = {
            install = require('mp.util').pc({
                'clangd',
                'csharp-language-server',
            }),
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            clangd = require('mp.util').pc({}),
            csharp_ls = require('mp.util').pc({}),
        },
    },
}
