return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context',
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    opts = {
        -- Add just when possible: https://github.com/nvim-treesitter/nvim-treesitter/pull/6245
        ensure_installed = { 'dart', 'dockerfile', 'kotlin', 'latex', 'scala', 'yaml' },
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
