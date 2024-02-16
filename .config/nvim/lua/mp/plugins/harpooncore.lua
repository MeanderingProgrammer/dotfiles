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

        local mark = require('harpoon-core.mark')
        local ui = require('harpoon-core.ui')
        local map = require('mp.config.utils').leader_map

        map('ha', mark.add_file, 'Harpoon: Add current file')
        map('hr', mark.rm_file, 'Harpoon: Remove current file')
        map('hu', ui.toggle_quick_menu, 'Harpoon: Toggle UI')
        map('hn', ui.nav_next, 'Harpoon: Next file')
        map('hp', ui.nav_prev, 'Harpoon: Previous file')
        for i = 1, 5 do
            map(i, ui.nav_file, 'Harpoon: Open file ' .. i, i)
        end

        require('telescope').load_extension('harpoon-core')
        map('ht', 'Telescope harpoon-core marks', 'Harpoon: Telescope menu')
    end,
}
