local util = require('mp.util')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'bash' },
        },
    },
    {
        'mason-org/mason.nvim',
        opts = {
            install = { 'bash-language-server' },
            linters = {
                bash = util.pc({ 'shellcheck' }),
                sh = util.pc({ 'shellcheck' }),
                zsh = util.pc({ 'shellcheck' }),
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            bashls = {
                enabled = true,
                filetypes = { 'sh', 'zsh' },
            },
        },
    },
}
