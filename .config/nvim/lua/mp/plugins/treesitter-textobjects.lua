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

        -- repeat movement with ';' and ',' without breaking it for f / t
        local map = vim.keymap.set
        local ts_repeat = require('nvim-treesitter.textobjects.repeatable_move')
        map({ 'n', 'x', 'o' }, ';', ts_repeat.repeat_last_move_next)
        map({ 'n', 'x', 'o' }, ',', ts_repeat.repeat_last_move_previous)
        map({ 'n', 'x', 'o' }, 'f', ts_repeat.builtin_f_expr, { expr = true })
        map({ 'n', 'x', 'o' }, 'F', ts_repeat.builtin_F_expr, { expr = true })
        map({ 'n', 'x', 'o' }, 't', ts_repeat.builtin_t_expr, { expr = true })
        map({ 'n', 'x', 'o' }, 'T', ts_repeat.builtin_T_expr, { expr = true })
    end,
}
