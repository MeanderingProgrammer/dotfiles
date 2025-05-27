return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { languages = { 'terraform' } },
    },
    {
        'mason-org/mason.nvim',
        opts = {
            install = require('mp.util').pc({ 'terraform-ls' }),
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            terraformls = require('mp.util').pc({}),
        },
    },
}
