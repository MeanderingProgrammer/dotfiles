return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'debugloop/telescope-undo.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    keys = {
        { '<leader>f', '<cmd>Telescope find_files<cr>', desc = 'Telescope: Find files' },
        { '<leader>g', '<cmd>Telescope live_grep<cr>', desc = 'Telescope: Grep files' },
    },
    config = function()
        local telescope = require('telescope')
        telescope.setup({})
        telescope.load_extension('fzf')
    end,
}
