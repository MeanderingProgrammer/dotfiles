return {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        local telescope = require('telescope')
        telescope.load_extension('fzf')
    end,
}
