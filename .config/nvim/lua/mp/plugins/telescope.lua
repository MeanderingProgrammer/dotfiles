return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'debugloop/telescope-undo.nvim',
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

        local function keymap_filter(keymap)
            local descriptors = {}
            vim.list_extend(descriptors, { 'Telescope', 'Harpoon', 'LSP', 'NvimTree', 'Dashboard', 'FTerm' })
            vim.list_extend(descriptors, { 'textobject', 'named node', 'Goto', 'Swap' })
            if keymap.desc ~= nil then
                print(keymap.desc)
                for _, descriptor in ipairs(descriptors) do
                    if string.find(keymap.desc, descriptor) ~= nil then
                        return true
                    end
                end
            end
            return false
        end
        local keymap_options = { modes = { 'n', 'x' }, show_plug = false, filter = keymap_filter }
        map('<leader>th', builtin.keymaps, keymap_options, 'Show Keymaps')
    end,
}
