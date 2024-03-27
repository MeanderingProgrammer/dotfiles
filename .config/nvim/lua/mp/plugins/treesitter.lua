return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context',
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    opts = {
        ensure_installed = { 'dart', 'dockerfile', 'just', 'kotlin', 'latex', 'scala', 'yaml' },
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
    },
    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
    end,
}
