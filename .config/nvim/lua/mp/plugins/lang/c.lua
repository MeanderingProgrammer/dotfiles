local util = require('mp.util')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'c', 'c_sharp', 'cmake', 'cpp', 'make' },
        },
    },
    {
        'mason-org/mason.nvim',
        opts = {
            install = util.pc({ 'clangd', 'csharp-language-server' }),
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            clangd = util.pc({}),
            csharp_ls = util.pc({}),
        },
    },
}
