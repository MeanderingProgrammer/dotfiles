return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { languages = { 'latex' } },
    },
    {
        'mason-org/mason.nvim',
        opts = {
            install = require('mp.util').pc({ 'texlab' }),
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            texlab = require('mp.util').pc({}),
        },
    },
}
