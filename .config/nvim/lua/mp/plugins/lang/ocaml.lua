return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { languages = { 'ocaml' } },
    },
    {
        'mason-org/mason.nvim',
        opts = {
            install = require('mp.util').pc({
                'ocaml-lsp',
                'ocamlformat',
            }),
            formatters = {
                ocaml = require('mp.util').pc({ 'ocamlformat' }),
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            ocamllsp = require('mp.util').pc({}),
        },
    },
}
