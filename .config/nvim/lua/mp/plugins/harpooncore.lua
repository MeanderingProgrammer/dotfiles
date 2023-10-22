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

        local function map(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { desc = 'Harpoon: ' .. desc })
        end

        local mark = require('harpoon-core.mark')
        map('<leader>ha', mark.add_file, 'Add current file')
        map('<leader>hr', mark.rm_file, 'Remove current file')

        local ui = require('harpoon-core.ui')
        map('<leader>hu', ui.toggle_quick_menu, 'Toggle UI')
        map('<leader>hn', ui.nav_next, 'Next file')
        map('<leader>hp', ui.nav_prev, 'Previous file')
        for i = 1, 5 do
            local open_file = function()
                ui.nav_file(i)
            end
            map('<leader>' .. i, open_file, 'Open file ' .. i)
        end

        require('telescope').load_extension('harpoon-core')
        map('<leader>ht', '<cmd>Telescope harpoon-core marks<cr>', 'Telescope menu')
    end,
}
