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
        ---@type mp.lsp.Config
        opts = {
            terraformls = { enabled = vim.g.pc },
        },
    },
}
