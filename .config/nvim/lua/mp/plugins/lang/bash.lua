return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { languages = { 'bash' } },
    },
    {
        'mason-org/mason.nvim',
        opts = {
            install = { 'bash-language-server' },
            linters = {
                bash = require('mp.util').pc({ 'shellcheck' }),
                sh = require('mp.util').pc({ 'shellcheck' }),
                zsh = require('mp.util').pc({ 'shellcheck' }),
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            bashls = {
                filetypes = { 'sh', 'zsh' },
            },
        },
    },
}
