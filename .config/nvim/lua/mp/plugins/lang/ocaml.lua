return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'ocaml' },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            opts.servers.ocamllsp = {}
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = {
            formatters = {
                ocaml = { 'ocamlformat' },
            },
        },
    },
}
