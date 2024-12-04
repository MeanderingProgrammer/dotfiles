return {
    'MeanderingProgrammer/harpoon-core.nvim',
    dev = true,
    config = function()
        require('harpoon-core').setup({
            default_action = 'vs',
        })

        ---@param lhs string
        ---@param rhs string|function
        ---@param desc string
        local function map(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { desc = desc })
        end
        local mark = require('harpoon-core.mark')
        local ui = require('harpoon-core.ui')
        for i = 1, 5 do
            map(string.format('<leader>%d', i), function()
                ui.nav_file(i)
            end, string.format('Harpoon open file %d', i))
        end
        map('<leader>ha', mark.add_file, 'Add current file')
        map('<leader>hr', mark.rm_file, 'Remove current file')
        map('<leader>hu', ui.toggle_quick_menu, 'Toggle UI')
        map('<leader>hn', ui.nav_next, 'Next file')
        map('<leader>hp', ui.nav_prev, 'Previous file')
    end,
}
