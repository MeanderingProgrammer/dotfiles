local utils = require('mp.utils')

return {
    'stevearc/oil.nvim',
    dependencies = { 'echasnovski/mini.nvim' },
    config = function()
        local hidden = { '.DS_Store', '.project', '.classpath', '.factorypath' }
        vim.list_extend(hidden, utils.hidden_directories())

        local oil = require('oil')
        oil.setup({
            keymaps = {
                -- Use finder keymaps
                ['<C-c>'] = 'actions.close',
                ['<C-v>'] = 'actions.select_vsplit',
                ['<C-x>'] = 'actions.select_split',
                -- Disable navigation keymaps
                ['<C-h>'] = false,
                ['<C-l>'] = false,
            },
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name)
                    return vim.tbl_contains(hidden, name)
                end,
            },
            float = {
                padding = vim.g.android and 2 or 8,
            },
        })

        vim.keymap.set('n', '<leader>o', oil.toggle_float, {
            desc = 'Oil Toggle',
        })
    end,
}
