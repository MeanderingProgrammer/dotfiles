local Keymap = require('mp.lib.keymap')
local oil = require('oil')
local utils = require('mp.lib.utils')

local hidden = { '.DS_Store', '.project', '.classpath', '.factorypath' }
vim.list_extend(hidden, utils.hidden)

oil.setup({
    keymaps = {
        -- use finder keymaps
        ['<C-c>'] = 'actions.close',
        ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
        ['<C-x>'] = { 'actions.select', opts = { horizontal = true } },
        -- disable navigation keymaps
        ['<C-h>'] = false,
        ['<C-l>'] = false,
    },
    view_options = {
        show_hidden = true,
        is_always_hidden = function(name)
            return vim.list_contains(hidden, name)
        end,
    },
    float = {
        padding = (vim.o.columns < 100 or vim.o.lines < 40) and 2 or 8,
    },
})

Keymap.new({ prefix = '<leader>' }):n('o', oil.toggle_float, 'oil toggle')
