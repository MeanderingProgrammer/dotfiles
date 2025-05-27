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
            install = util.pc({ { 'zls', version = '0.13.0' } }),
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            zls = util.pc({}),
        },
    },
}
