local utils = require('mp.utils')

return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'debugloop/telescope-undo.nvim',
    },
    config = function()
        local find_command = { 'rg', '--files', '--hidden' }
        for _, directory in ipairs(utils.hidden_directories()) do
            vim.list_extend(find_command, { '-g', string.format('!**/%s/*', directory) })
        end

        local telescope = require('telescope')
        local actions = require('telescope.actions')
        telescope.setup({
            defaults = {
                layout_strategy = 'vertical',
                layout_config = { preview_height = 0.4 },
                mappings = {
                    i = {
                        ['<C-c>'] = actions.close,
                        ['<cr>'] = actions.select_drop,
                        ['<tab>'] = actions.move_selection_next,
                        ['<S-tab>'] = actions.move_selection_previous,
                    },
                },
            },
            pickers = {
                find_files = { find_command = find_command },
                lsp_definitions = { jump_type = 'never' },
                lsp_implementations = { jump_type = 'never' },
                lsp_references = { jump_type = 'never' },
            },
        })

        telescope.load_extension('fzf')
        telescope.load_extension('undo')

        ---@param lhs string
        ---@param rhs string|function
        ---@param desc string
        local function map(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { desc = desc })
        end
        local builtin = require('telescope.builtin')
        map('<leader><leader>', builtin.find_files, 'Find Files')
        map('<leader>ts', builtin.live_grep, 'Grep Files')
        map('<leader>td', builtin.diagnostics, 'Diagnostics')
        map('<leader>tr', builtin.resume, 'Resume')
        map('<leader>?', builtin.oldfiles, 'Find Recently Opened Files')
        map('<leader>tb', builtin.buffers, 'Find Existing Buffers')
        map('<leader>tg', builtin.git_files, 'Git Files')
        map('<leader>tu', '<cmd>Telescope undo<cr>', 'Undo Tree')
        map('<leader>tw', builtin.grep_string, 'Current Word')
        map('<leader>tt', builtin.help_tags, 'Help Tags')
        map('<leader>tk', builtin.keymaps, 'Keymaps')
        map('<leader>th', builtin.highlights, 'Highlights')
    end,
}
