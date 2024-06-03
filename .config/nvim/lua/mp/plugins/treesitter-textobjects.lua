return {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup({
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ['l='] = '@assignment.lhs',
                        ['r='] = '@assignment.rhs',

                        ['ap'] = '@parameter.outer',
                        ['ip'] = '@parameter.inner',

                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',

                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
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
                        ['<leader>np'] = '@parameter.inner',
                        ['<leader>nf'] = '@function.outer',
                    },
                    swap_previous = {
                        ['<leader>pp'] = '@parameter.inner',
                        ['<leader>pf'] = '@function.outer',
                    },
                },
            },
        })

        -- Repeat movement with ';' and ',' without breaking it for f / t
        local modes = { 'n', 'x', 'o' }
        local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')
        vim.keymap.set(modes, ';', ts_repeat_move.repeat_last_move_next)
        vim.keymap.set(modes, ',', ts_repeat_move.repeat_last_move_previous)
        vim.keymap.set(modes, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
        vim.keymap.set(modes, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
        vim.keymap.set(modes, 't', ts_repeat_move.builtin_t_expr, { expr = true })
        vim.keymap.set(modes, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
    end,
}
