return {
    'MeanderingProgrammer/harpoon-core.nvim',
    dev = true,
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        require('harpoon-core').setup({})

        local mark = require('harpoon-core.mark')
        vim.keymap.set('n', '<leader>a', mark.add_file, { desc = 'Harpoon: Add current file' })
        vim.keymap.set('n', '<leader>r', mark.rm_file, { desc = 'Harpoon: Remove current file' })

        local ui = require('harpoon-core.ui')
        vim.keymap.set('n', '<leader><leader>', ui.toggle_quick_menu, { desc = 'Harpoon: Toggle UI' })
        vim.keymap.set('n', '<leader>n', ui.nav_next, { desc = 'Harpoon: Next file' })
        vim.keymap.set('n', '<leader>p', ui.nav_prev, { desc = 'Harpoon: Previous file' })
        for i = 1, 5 do
            local open_file = function()
                ui.nav_file(i)
            end
            vim.keymap.set('n', '<leader>' .. i, open_file, { desc = 'Harpoon: Open file ' .. i })
        end
    end,
}
