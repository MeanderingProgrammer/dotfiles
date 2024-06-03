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
    config = function(_, opts)
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup({
            ensure_installed = opts.languages,
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<c-v>',
                    node_incremental = 'v',
                    node_decremental = 'V',
                    scope_incremental = false,
                },
            },
        })
    end,
}
