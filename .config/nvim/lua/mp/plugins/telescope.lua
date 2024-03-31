return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'debugloop/telescope-undo.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')
        telescope.setup({ defaults = { mappings = {
            i = { ['<cr>'] = actions.select_drop },
        } } })

        telescope.load_extension('fzf')
        telescope.load_extension('undo')

        local builtin = require('telescope.builtin')
        local find_files = require('mp.utils').thunk(builtin.find_files, {
            find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
        })
        require('which-key').register({
            ['<leader>'] = {
                ['<leader>'] = { builtin.buffers, 'Find Existing Buffers' },
                ['?'] = { builtin.oldfiles, 'Find Recently Opened Files' },
            },
            ['<leader>t'] = {
                name = 'telescope',
                f = { find_files, 'Find Files' },
                g = { builtin.live_grep, 'Grep Files' },
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
