local util = require('mp.util')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'zig' },
        },
    },
    {
        'mason-org/mason.nvim',
        opts = {
            install = util.pc({ 'zls' }),
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            zls = util.pc({}),
        },
    },
}
