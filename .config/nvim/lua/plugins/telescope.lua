return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'debugloop/telescope-undo.nvim',
    },
    keys = {
        { '<leader>f', '<cmd>Telescope find_files<cr>', desc = 'Telescope: Find files' },
        { '<leader>g', '<cmd>Telescope live_grep<cr>', desc = 'Telescope: Grep files' },
    },
    config = function()
        require('telescope').setup({})
    end,
}
