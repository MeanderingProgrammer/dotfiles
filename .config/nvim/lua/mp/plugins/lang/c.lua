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
        ---@type mp.lsp.Config
        opts = {
            clangd = { enabled = vim.g.pc },
            csharp_ls = { enabled = vim.g.pc },
        },
    },
}
