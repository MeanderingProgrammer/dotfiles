return {
    'MeanderingProgrammer/harpoon-core.nvim',
    dev = true,
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        require('harpoon-core').setup({})

        -- local mark = require('harpoon.mark')
        -- local ui = require('harpoon.ui')
        --
        -- vim.keymap.set('n', '<leader>a', mark.add_file, { desc = 'Harpoon: Add current file' })
        -- vim.keymap.set('n', '<leader>r', mark.rm_file, { desc = 'Harpoon: Remove current file' })
        -- vim.keymap.set('n', '<leader><leader>', ui.toggle_quick_menu, { desc = 'Harpoon: Toggle UI' })
        --
        -- for i = 1, 5 do
        --     local open_file = function()
        --         ui.nav_file(i)
        --     end
        --     vim.keymap.set('n', '<leader>' .. i, open_file, { desc = 'Harpoon: Open file ' .. i })
        -- end
    end,
}
