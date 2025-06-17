return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'ocaml' },
        },
    },
    {
        'mason-org/mason.nvim',
        ---@type mp.mason.Config
        opts = {
            ['ocaml-lsp'] = { install = vim.g.computer },
            ocamlformat = { install = vim.g.computer },
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
