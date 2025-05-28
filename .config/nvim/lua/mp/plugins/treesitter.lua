return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context',
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    opts = {
        languages = {},
    },
    opts_extend = { 'languages' },
    config = function(_, opts)
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup({
            ensure_installed = opts.languages,
            indent = { enable = true },
        })
    end,
}
