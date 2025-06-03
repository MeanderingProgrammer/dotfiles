return {
    'MeanderingProgrammer/harpoon-core.nvim',
    dev = true,
    dependencies = { 'echasnovski/mini.nvim' },
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
            map(('<leader>%d'):format(i), function()
                harpoon.nav_file(i)
            end, ('harpoon open file %d'):format(i))
        end
        map('<leader>ha', harpoon.add_file, 'add current file')
        map('<leader>hr', harpoon.rm_file, 'remove current file')
        map('<leader>hu', harpoon.toggle_quick_menu, 'toggle UI')
        map('<leader>hn', harpoon.nav_next, 'next file')
        map('<leader>hp', harpoon.nav_prev, 'previous file')
    end,
}
