return {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'debugloop/telescope-undo.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    keys = {
        { '<leader>f', '<cmd>Telescope find_files<cr>', desc = 'Telescope: Find files' },
        { '<leader>g', '<cmd>Telescope live_grep<cr>', desc = 'Telescope: Grep files' },
        { 'gd', '<cmd>Telescope lsp_definitions<cr>', desc = 'Telescope: Goto definitions' },
        { 'gr', '<cmd>Telescope lsp_references<cr>', desc = 'Telescope: Goto References' },
    },
    config = function()
        local telescope = require('telescope')
        telescope.setup({})
        telescope.load_extension('fzf')
    end,
}
