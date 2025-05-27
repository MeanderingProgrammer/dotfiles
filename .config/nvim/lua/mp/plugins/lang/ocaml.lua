local util = require('mp.util')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'ocaml' },
        },
    },
    {
        'mason-org/mason.nvim',
        opts = {
            install = util.pc({ 'ocaml-lsp', 'ocamlformat' }),
            formatters = {
                ocaml = util.pc({ 'ocamlformat' }),
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            ocamllsp = util.pc({}),
        },
    },
}
