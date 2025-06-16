local util = require('mp.util')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'latex' },
        },
    },
    {
        'mason-org/mason.nvim',
        opts = {
            install = util.pc({ 'texlab' }),
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            texlab = { enabled = vim.g.pc },
        },
    },
}
