return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'debugloop/telescope-undo.nvim',
        'pschmitt/telescope-yadm.nvim',
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')

        telescope.setup({
            defaults = {
                mappings = {
                    i = { ['<cr>'] = actions.select_drop },
                },
            },
            pickers = {
                find_files = {
                    find_command = {
                        'rg',
                        '--files',
                        '--hidden',
                        '-g',
                        '!**/.git/*',
                        '-g',
                        '!**/target/*',
                        '-g',
                        '!**/.mypy_cache/*',
                    },
                },
            },
        })

        telescope.load_extension('fzf')
        telescope.load_extension('undo')
        telescope.load_extension('yadm_files')

        local builtin = require('telescope.builtin')
        require('which-key').register({
            ['<leader>'] = {
                ['<leader>'] = { builtin.buffers, 'Find Existing Buffers' },
                ['?'] = { builtin.oldfiles, 'Find Recently Opened Files' },
            },
            ['<leader>t'] = {
                name = 'telescope',
                f = { builtin.find_files, 'Find Files' },
                g = { builtin.git_files, 'Git Files' },
                y = { '<cmd>Telescope yadm_files<cr>', 'YADM files' },
                s = { builtin.live_grep, 'Grep Files' },
                u = { '<cmd>Telescope undo<cr>', 'Undo Tree' },
                d = { builtin.diagnostics, 'Diagnostics' },
                w = { builtin.grep_string, 'Current Word' },
                t = { builtin.help_tags, 'Help Tags' },
                k = { builtin.keymaps, 'Keymaps' },
                h = { builtin.highlights, 'Highlights' },
            },
        })
    end,
}
