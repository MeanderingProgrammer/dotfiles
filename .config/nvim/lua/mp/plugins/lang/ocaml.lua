return {
    {
        'nvim-treesitter/nvim-treesitter',
        ---@type mp.ts.Config
        opts = {
            ocaml = { install = true },
        },
    },
    {
        'mason-org/mason.nvim',
        ---@type mp.mason.Config
        opts = {
            ['ocaml-lsp'] = { install = vim.g.has.opam },
            ['ocamlformat'] = { install = vim.g.has.opam },
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            ocamllsp = {},
        },
    },
    {
        'stevearc/conform.nvim',
        ---@type mp.conform.Config
        opts = {
            ocamlformat = { filetypes = { 'ocaml' } },
        },
    },
}
