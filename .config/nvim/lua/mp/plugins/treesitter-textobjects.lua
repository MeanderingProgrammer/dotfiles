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

        -- Repeat movement with ; and , without breaking it for f / t
        local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')
        vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
        vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)
        vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f)
        vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F)
        vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t)
        vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T)
    end,
}
