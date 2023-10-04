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
        {
            'gd',
            function()
                require('telescope.builtin').lsp_definitions({ jump_type = 'never' })
            end,
            desc = 'Telescope: Goto Definitions',
        },
        {
            'gr',
            function()
                require('telescope.builtin').lsp_references({ jump_type = 'never' })
            end,
            desc = 'Telescope: Goto References',
        },
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')
        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ['<cr>'] = actions.select_tab_drop,
                    },
                },
            },
        })
        telescope.load_extension('fzf')
    end,
}
