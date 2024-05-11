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
        require('telescope').load_extension('harpoon-core')

        local mark = require('harpoon-core.mark')
        local ui = require('harpoon-core.ui')

        require('which-key').register({
            ['<leader>'] = {
                ['1'] = {
                    function()
                        ui.nav_file(1)
                    end,
                    'Harpoon Open file 1',
                },
                ['2'] = {
                    function()
                        ui.nav_file(2)
                    end,
                    'Harpoon Open file 2',
                },
                ['3'] = {
                    function()
                        ui.nav_file(3)
                    end,
                    'Harpoon Open file 3',
                },
                ['4'] = {
                    function()
                        ui.nav_file(4)
                    end,
                    'Harpoon Open file 4',
                },
                ['5'] = {
                    function()
                        ui.nav_file(5)
                    end,
                    'Harpoon Open file 5',
                },
            },
            ['<leader>h'] = {
                name = 'harpoon',
                a = { mark.add_file, 'Add current file' },
                r = { mark.rm_file, 'Remove current file' },
                u = { ui.toggle_quick_menu, 'Toggle UI' },
                t = { '<cmd>Telescope harpoon-core marks<cr>', 'Telescope menu' },
                n = { ui.nav_next, 'Next file' },
                p = { ui.nav_prev, 'Previous file' },
            },
        })
    end,
}
