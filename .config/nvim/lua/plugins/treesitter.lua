return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
        'nvim-treesitter/playground',
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup({
            ensure_installed = 'all',
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<c-v>',
                    node_incremental = 'v',
                    node_decremental = 'V',
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ['po'] = '@parameter.outer',
                        ['pi'] = '@parameter.inner',
                        ['fo'] = '@function.outer',
                        ['fi'] = '@function.inner',
                        ['co'] = '@class.outer',
                        ['ci'] = '@class.inner',
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        [']f'] = '@function.outer',
                        [']c'] = '@class.outer',
                    },
                    goto_next_end = {
                        [']F'] = '@function.outer',
                        [']C'] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['[f'] = '@function.outer',
                        ['[c'] = '@class.outer',
                    },
                    goto_previous_end = {
                        ['[F'] = '@function.outer',
                        ['[C'] = '@class.outer',
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ['<leader>a'] = '@parameter.inner',
                    },
                    swap_previous = {
                        ['<leader>A'] = '@parameter.inner',
                    },
                },
            },
        })
    end,
}
