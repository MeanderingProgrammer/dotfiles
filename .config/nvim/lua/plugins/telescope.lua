return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'debugloop/telescope-undo.nvim',
    },
    keys = {
        { '<C-f>', '<cmd>lua require("telescope.builtin").find_files()<cr>' },
    },
    config = function()
        require('telescope').setup({})
    end,
}
