return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { languages = { 'zig' } },
    },
    {
        'mason-org/mason.nvim',
        opts = {
            install = require('mp.util').pc({
                { 'zls', version = '0.13.0' },
            }),
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            zls = require('mp.util').pc({}),
        },
    },
}
