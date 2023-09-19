return {
    'ThePrimeagen/harpoon',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        require('harpoon').setup({})

        local mark = require('harpoon.mark')
        local ui = require('harpoon.ui')

        vim.keymap.set('n', '<leader>a', mark.add_file, { desc = 'Harpoon: Add current file' })
        vim.keymap.set('n', '<leader>r', mark.rm_file, { desc = 'Harpoon: Remove current file' })
        vim.keymap.set('n', '<leader><leader>', ui.toggle_quick_menu, { desc = 'Harpoon: Toggle UI' })

        for i = 1, 5 do
            local key = string.format('<leader>%s', i)
            local description = string.format('Harpoon: Open file %s', i)
            vim.keymap.set('n', key, function() ui.nav_file(i) end, { desc = description })
        end
    end
}
