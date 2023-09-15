return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'debugloop/telescope-undo.nvim',
    },
    keys = {
        { '<leader>f', '<cmd>Telescope find_files<cr>' },
    },
    config = function()
        require('telescope').setup({})
    end,
}
