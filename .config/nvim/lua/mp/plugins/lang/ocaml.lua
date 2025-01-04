return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { languages = { 'ocaml' } },
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            if not vim.g.android then
                table.insert(opts.install, 'ocaml-lsp')
                table.insert(opts.install, 'ocamlformat')
                opts.formatters.ocaml = { 'ocamlformat' }
            end
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            if not vim.g.android then
                opts.servers.ocamllsp = {}
            end
        end,
    },
}
