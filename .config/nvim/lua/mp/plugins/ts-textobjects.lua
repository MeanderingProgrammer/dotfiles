local Keymap = require('mp.keymap')

return {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require('nvim-treesitter-textobjects').setup({
            select = { lookahead = true },
        })

        ---@param f fun(name: string)
        ---@param name string
        ---@return fun()
        local function wrap(f, name)
            return function()
                f(name)
            end
        end

        local select = require('nvim-treesitter-textobjects.select')
        Keymap.new({ mode = { 'x', 'o' } })
            :set('l=', wrap(select.select_textobject, '@assignment.lhs'))
            :set('r=', wrap(select.select_textobject, '@assignment.rhs'))
            :set('ap', wrap(select.select_textobject, '@parameter.outer'))
            :set('ip', wrap(select.select_textobject, '@parameter.inner'))
            :set('af', wrap(select.select_textobject, '@function.outer'))
            :set('if', wrap(select.select_textobject, '@function.inner'))
            :set('ac', wrap(select.select_textobject, '@class.outer'))
            :set('ic', wrap(select.select_textobject, '@class.inner'))

        local swap = require('nvim-treesitter-textobjects.swap')
        Keymap.new({ mode = 'n', prefix = '<leader>' })
            :set('np', wrap(swap.swap_next, '@parameter.inner'))
            :set('nf', wrap(swap.swap_next, '@function.outer'))
            :set('pp', wrap(swap.swap_previous, '@parameter.inner'))
            :set('pf', wrap(swap.swap_previous, '@function.outer'))

        local move = require('nvim-treesitter-textobjects.move')
        Keymap.new({ mode = { 'n', 'x', 'o' } })
            :set(']f', wrap(move.goto_next_start, '@function.outer'))
            :set(']c', wrap(move.goto_next_start, '@class.outer'))
            :set(']F', wrap(move.goto_next_end, '@function.outer'))
            :set(']C', wrap(move.goto_next_end, '@class.outer'))
            :set('[f', wrap(move.goto_previous_start, '@function.outer'))
            :set('[c', wrap(move.goto_previous_start, '@class.outer'))
            :set('[F', wrap(move.goto_previous_end, '@function.outer'))
            :set('[C', wrap(move.goto_previous_end, '@class.outer'))

        -- repeat movement with ';' and ',' without breaking f / t
        local ts_repeat = require('nvim-treesitter-textobjects.repeatable_move')
        Keymap.new({ mode = { 'n', 'x', 'o' }, expr = true })
            :set(';', ts_repeat.repeat_last_move_next)
            :set(',', ts_repeat.repeat_last_move_previous)
            :set('f', ts_repeat.builtin_f_expr)
            :set('F', ts_repeat.builtin_F_expr)
            :set('t', ts_repeat.builtin_t_expr)
            :set('T', ts_repeat.builtin_T_expr)
    end,
}
