return {
    'ThePrimeagen/harpoon',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        require('harpoon').setup({})

        local mark = require('harpoon.mark')
        local ui = require('harpoon.ui')

        vim.keymap.set('n', '<leader>a', mark.add_file)
        vim.keymap.set('n', '<leader>r', mark.rm_file)
        vim.keymap.set('n', '<leader><leader>', ui.toggle_quick_menu)

        for i = 1, 5 do
            vim.keymap.set('n', string.format('<leader>%s', i), function() ui.nav_file(i) end)
        end
    end
}
