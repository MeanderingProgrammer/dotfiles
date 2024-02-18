return {
    'MeanderingProgrammer/harpoon-core.nvim',
    dev = true,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        require('harpoon-core').setup({
            default_action = 'vs',
        })
        require('telescope').load_extension('harpoon-core')

        local mark = require('harpoon-core.mark')
        local ui = require('harpoon-core.ui')
        local utils = require('mp.config.utils')

        ---@param lhs string|integer
        ---@param rhs fun()|string
        ---@param desc string
        local function map(lhs, rhs, desc)
            vim.keymap.set('n', '<leader>' .. lhs, rhs, {
                silent = true,
                desc = 'Harpoon: ' .. desc,
            })
        end
        map('ha', mark.add_file, 'Add current file')
        map('hr', mark.rm_file, 'Remove current file')
        map('hu', ui.toggle_quick_menu, 'Toggle UI')
        map('ht', '<cmd>Telescope harpoon-core marks<cr>', 'Telescope menu')
        map('hn', ui.nav_next, 'Next file')
        map('hp', ui.nav_prev, 'Previous file')
        for i = 1, 5 do
            map(i, utils.thunk(ui.nav_file, i), 'Open file ' .. i)
        end
    end,
}
