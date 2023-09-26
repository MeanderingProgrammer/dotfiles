return {
    'ThePrimeagen/harpoon',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        require('harpoon').setup({})

        local mark = require('harpoon.mark')
        local ui = require('harpoon.ui')

        vim.keymap.set('n', '<C-a>', mark.add_file, { desc = 'Harpoon: Add current file' })
        vim.keymap.set('n', '<C-r>', mark.rm_file, { desc = 'Harpoon: Remove current file' })
        vim.keymap.set('n', '<C-d>', ui.toggle_quick_menu, { desc = 'Harpoon: Toggle UI' })
    end,
}
