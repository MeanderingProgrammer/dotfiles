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
        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ['<cr>'] = actions.select_drop,
                    },
                },
            },
        })

        local function map(lhs, f, opts, desc)
            local function rhs()
                f(opts)
            end
            vim.keymap.set('n', lhs, rhs, { desc = 'Telescope: ' .. desc })
        end
        local builtin = require('telescope.builtin')
        map('<leader><leader>', builtin.buffers, {}, 'Find Existing Buffers')
        map('<leader>?', builtin.oldfiles, {}, 'Find Recently Opened Files')
        map('<leader>tf', builtin.find_files, {}, 'Find Files')
        map('<leader>tg', builtin.live_grep, {}, 'Grep Files')
        map('<leader>td', builtin.diagnostics, {}, 'Diagnostics')
        map('<leader>tw', builtin.grep_string, {}, 'Current Word')
        map('<leader>tt', builtin.help_tags, {}, 'Help Tags')

        local descriptors = {}
        vim.list_extend(descriptors, { 'Telescope', 'Harpoon', 'LSP', 'NvimTree', 'Dashboard' })
        vim.list_extend(descriptors, { 'FTerm', 'Crates', 'Session' })
        vim.list_extend(descriptors, { 'textobject', 'named node', 'Goto', 'Swap' })
        local function keymap_filter(keymap)
            if keymap.desc == nil then
                return false
            end
            for _, descriptor in ipairs(descriptors) do
                if string.find(keymap.desc, descriptor) ~= nil then
                    return true
                end
            end
            return false
        end
        local keymap_options = { modes = { 'n', 'x' }, filter = keymap_filter }
        map('<leader>th', builtin.keymaps, keymap_options, 'Show Keymaps')

        telescope.load_extension('fzf')
        telescope.load_extension('undo')
    end,
}
