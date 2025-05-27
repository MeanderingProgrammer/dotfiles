local util = require('mp.util')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'terraform' },
        },
    },
    {
        'mason-org/mason.nvim',
        opts = {
            install = util.pc({ 'terraform-ls' }),
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            terraformls = util.pc({}),
        },
    },
}
