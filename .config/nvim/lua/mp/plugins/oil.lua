local utils = require('mp.utils')

return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local hidden_files = { '.DS_Store' }
        vim.list_extend(hidden_files, utils.hidden_directories())
        local padding = utils.is_android and 2 or 8

        local oil = require('oil')
        oil.setup({
            keymaps = {
                -- Use telescope keymaps
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
                    return vim.tbl_contains(hidden_files, name)
                end,
            },
            float = { padding = padding },
        })

        vim.keymap.set('n', '<leader>o', oil.toggle_float, { desc = 'Oil Toggle' })
    end,
}
