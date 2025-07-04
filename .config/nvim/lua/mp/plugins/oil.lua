return {
    'stevearc/oil.nvim',
    dependencies = { 'echasnovski/mini.nvim' },
    config = function()
        local hidden = { '.DS_Store', '.project', '.classpath', '.factorypath' }
        vim.list_extend(hidden, require('mp.util').path.hidden)

        local oil = require('oil')
        oil.setup({
            keymaps = {
                -- use finder keymaps
                ['<C-c>'] = 'actions.close',
                ['<C-v>'] = 'actions.select_vsplit',
                ['<C-x>'] = 'actions.select_split',
                -- disable navigation keymaps
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
                padding = (vim.o.columns < 100 or vim.o.lines < 40) and 2 or 8,
            },
        })

        vim.keymap.set('n', '<leader>o', oil.toggle_float, {
            desc = 'oil toggle',
        })
    end,
}
