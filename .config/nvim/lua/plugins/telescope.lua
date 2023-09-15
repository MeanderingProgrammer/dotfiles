return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'debugloop/telescope-undo.nvim',
    },
    keys = {
        { '<leader>f', '<cmd>Telescope find_files<cr>' },
        { '<leader>g', '<cmd>Telescope live_grep<cr>' },
    },
    config = function()
        require('telescope').setup({})
    end,
}
