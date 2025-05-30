return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context',
        { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
        { 'MeanderingProgrammer/treesitter-modules.nvim', dev = true },
    },
    opts = {
        languages = {},
    },
    opts_extend = { 'languages' },
    config = function(_, opts)
        require('nvim-treesitter').setup({})

        require('nvim-treesitter-textobjects').setup({
            select = { lookahead = true },
        })

        require('treesitter-modules').setup({
            ensure_installed = opts.languages,
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<C-v>',
                    node_incremental = 'v',
                    node_decremental = 'V',
                    scope_incremental = false,
                },
            },
        })

        local map = vim.keymap.set

        ---@param mode string|string[]
        ---@param lhs string
        ---@param rhs fun(name: string)
        ---@param name string
        local function keymap(mode, lhs, rhs, name)
            map(mode, lhs, function()
                rhs(name)
            end)
        end

        local select = require('nvim-treesitter-textobjects.select')
        local select_mode = { 'x', 'o' }
        keymap(select_mode, 'l=', select.select_textobject, '@assignment.lhs')
        keymap(select_mode, 'r=', select.select_textobject, '@assignment.rhs')
        keymap(select_mode, 'ap', select.select_textobject, '@parameter.outer')
        keymap(select_mode, 'ip', select.select_textobject, '@parameter.inner')
        keymap(select_mode, 'af', select.select_textobject, '@function.outer')
        keymap(select_mode, 'if', select.select_textobject, '@function.inner')
        keymap(select_mode, 'ac', select.select_textobject, '@class.outer')
        keymap(select_mode, 'ic', select.select_textobject, '@class.inner')

        local move = require('nvim-treesitter-textobjects.move')
        local move_mode = { 'n', 'x', 'o' }
        keymap(move_mode, ']f', move.goto_next_start, '@function.outer')
        keymap(move_mode, ']c', move.goto_next_start, '@class.outer')
        keymap(move_mode, ']F', move.goto_next_end, '@function.outer')
        keymap(move_mode, ']C', move.goto_next_end, '@class.outer')
        keymap(move_mode, '[f', move.goto_previous_start, '@function.outer')
        keymap(move_mode, '[c', move.goto_previous_start, '@class.outer')
        keymap(move_mode, '[F', move.goto_previous_end, '@function.outer')
        keymap(move_mode, '[C', move.goto_previous_end, '@class.outer')

        local swap = require('nvim-treesitter-textobjects.swap')
        local swap_mode = 'n'
        keymap(swap_mode, '<leader>np', swap.swap_next, '@parameter.inner')
        keymap(swap_mode, '<leader>nf', swap.swap_next, '@function.outer')
        keymap(swap_mode, '<leader>pp', swap.swap_previous, '@parameter.inner')
        keymap(swap_mode, '<leader>pf', swap.swap_previous, '@function.outer')

        -- repeat movement with ';' and ',' without breaking it for f / t
        local ts_repeat = require('nvim-treesitter-textobjects.repeatable_move')
        map(move_mode, ';', ts_repeat.repeat_last_move_next)
        map(move_mode, ',', ts_repeat.repeat_last_move_previous)
        map(move_mode, 'f', ts_repeat.builtin_f_expr, { expr = true })
        map(move_mode, 'F', ts_repeat.builtin_F_expr, { expr = true })
        map(move_mode, 't', ts_repeat.builtin_t_expr, { expr = true })
        map(move_mode, 'T', ts_repeat.builtin_T_expr, { expr = true })
    end,
}
