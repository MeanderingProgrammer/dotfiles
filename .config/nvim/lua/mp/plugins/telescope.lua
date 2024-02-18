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
        local mappings = { ['<cr>'] = actions.select_drop }
        telescope.setup({ defaults = { mappings = { i = mappings } } })

        telescope.load_extension('fzf')
        telescope.load_extension('undo')

        local builtin = require('telescope.builtin')
        require('which-key').register({
            ['<leader>'] = {
                ['<leader>'] = { builtin.buffers, 'Find Existing Buffers' },
                ['?'] = { builtin.oldfiles, 'Find Recently Opened Files' },
            },
            ['<leader>t'] = {
                name = 'telescope',
                f = { builtin.find_files, 'Find Files' },
                g = { builtin.live_grep, 'Grep Files' },
                d = { builtin.diagnostics, 'Diagnostics' },
                w = { builtin.grep_string, 'Current Word' },
                t = { builtin.help_tags, 'Help Tags' },
                h = { builtin.keymaps, 'Show Keymaps' },
            },
        })
    end,
}
