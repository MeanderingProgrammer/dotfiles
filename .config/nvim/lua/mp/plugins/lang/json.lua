return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { languages = { 'jq', 'json', 'json5', 'jsonc' } },
    },
    {
        'mason-org/mason.nvim',
        opts = {
            install = require('mp.util').pc({ 'json-lsp' }),
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            jsonls = require('mp.util').pc({}),
        },
    },
}
