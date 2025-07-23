return {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require('nvim-treesitter-textobjects').setup({
            select = { lookahead = true },
        })

        local keymap = vim.keymap.set

        ---@param mode string|string[]
        ---@param lhs string
        ---@param rhs fun(name: string)
        ---@param name string
        local function map(mode, lhs, rhs, name)
            keymap(mode, lhs, function()
                rhs(name)
            end)
        end

        local select = require('nvim-treesitter-textobjects.select')
        local select_mode = { 'x', 'o' }
        map(select_mode, 'l=', select.select_textobject, '@assignment.lhs')
        map(select_mode, 'r=', select.select_textobject, '@assignment.rhs')
        map(select_mode, 'ap', select.select_textobject, '@parameter.outer')
        map(select_mode, 'ip', select.select_textobject, '@parameter.inner')
        map(select_mode, 'af', select.select_textobject, '@function.outer')
        map(select_mode, 'if', select.select_textobject, '@function.inner')
        map(select_mode, 'ac', select.select_textobject, '@class.outer')
        map(select_mode, 'ic', select.select_textobject, '@class.inner')

        local swap = require('nvim-treesitter-textobjects.swap')
        local swap_mode = 'n'
        map(swap_mode, '<leader>np', swap.swap_next, '@parameter.inner')
        map(swap_mode, '<leader>nf', swap.swap_next, '@function.outer')
        map(swap_mode, '<leader>pp', swap.swap_previous, '@parameter.inner')
        map(swap_mode, '<leader>pf', swap.swap_previous, '@function.outer')

        local move = require('nvim-treesitter-textobjects.move')
        local move_mode = { 'n', 'x', 'o' }
        map(move_mode, ']f', move.goto_next_start, '@function.outer')
        map(move_mode, ']c', move.goto_next_start, '@class.outer')
        map(move_mode, ']F', move.goto_next_end, '@function.outer')
        map(move_mode, ']C', move.goto_next_end, '@class.outer')
        map(move_mode, '[f', move.goto_previous_start, '@function.outer')
        map(move_mode, '[c', move.goto_previous_start, '@class.outer')
        map(move_mode, '[F', move.goto_previous_end, '@function.outer')
        map(move_mode, '[C', move.goto_previous_end, '@class.outer')

        -- repeat movement with ';' and ',' without breaking it for f / t
        local ts_repeat = require('nvim-treesitter-textobjects.repeatable_move')
        keymap(move_mode, ';', ts_repeat.repeat_last_move_next)
        keymap(move_mode, ',', ts_repeat.repeat_last_move_previous)
        keymap(move_mode, 'f', ts_repeat.builtin_f_expr, { expr = true })
        keymap(move_mode, 'F', ts_repeat.builtin_F_expr, { expr = true })
        keymap(move_mode, 't', ts_repeat.builtin_t_expr, { expr = true })
        keymap(move_mode, 'T', ts_repeat.builtin_T_expr, { expr = true })
    end,
}
