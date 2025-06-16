local util = require('mp.util')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'jq', 'json', 'json5', 'jsonc' },
        },
    },
    {
        'mason-org/mason.nvim',
        opts = {
            install = util.pc({ 'json-lsp' }),
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            jsonls = { enabled = vim.g.pc },
        },
    },
}
