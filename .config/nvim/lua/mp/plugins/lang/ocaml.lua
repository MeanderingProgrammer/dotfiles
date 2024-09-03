local utils = require('mp.utils')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { languages = { 'ocaml' } },
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            if utils.is_android then
                return
            end
            opts.mason.ocamllsp = {}
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            if utils.is_android then
                return
            end
            vim.list_extend(opts.ensure_installed, { 'ocamlformat' })
            opts.formatters.ocaml = { 'ocamlformat' }
        end,
    },
}
