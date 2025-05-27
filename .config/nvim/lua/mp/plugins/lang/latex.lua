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
        opts = {
            texlab = util.pc({}),
        },
    },
}
