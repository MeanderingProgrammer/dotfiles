return {
    'MeanderingProgrammer/harpoon-core.nvim',
    dev = true,
    config = function()
        local harpoon = require('harpoon-core')
        harpoon.setup({
            default_action = 'vs',
        })

        ---@param lhs string
        ---@param rhs string|function
        ---@param desc string
        local function map(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { desc = desc })
        end
        for i = 1, 5 do
            map(string.format('<leader>%d', i), function()
                harpoon.nav_file(i)
            end, string.format('Harpoon open file %d', i))
        end
        map('<leader>ha', harpoon.add_file, 'Add current file')
        map('<leader>hr', harpoon.rm_file, 'Remove current file')
        map('<leader>hu', harpoon.toggle_quick_menu, 'Toggle UI')
        map('<leader>hn', harpoon.nav_next, 'Next file')
        map('<leader>hp', harpoon.nav_prev, 'Previous file')
    end,
}
