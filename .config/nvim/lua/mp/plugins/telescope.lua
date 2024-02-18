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
        local mappings = { ['<cr>'] = actions.select_drop }
        telescope.setup({ defaults = { mappings = { i = mappings } } })

        local builtin = require('telescope.builtin')
        local utils = require('mp.config.utils')

        ---@param lhs string
        ---@param rhs fun()
        ---@param desc string
        local function map(lhs, rhs, desc)
            vim.keymap.set('n', '<leader>' .. lhs, rhs, {
                silent = true,
                desc = 'Telescope: ' .. desc,
            })
        end
        map('<leader>', builtin.buffers, 'Find Existing Buffers')
        map('?', builtin.oldfiles, 'Find Recently Opened Files')
        map('tf', builtin.find_files, 'Find Files')
        map('tg', builtin.live_grep, 'Grep Files')
        map('td', builtin.diagnostics, 'Diagnostics')
        map('tw', builtin.grep_string, 'Current Word')
        map('tt', builtin.help_tags, 'Help Tags')

        local descriptors = {}
        vim.list_extend(descriptors, { 'Harpoon', 'Dashboard', 'Requirements' })
        vim.list_extend(descriptors, { 'Telescope', 'LSP', 'NvimTree', 'FTerm', 'Crates', 'Session' })
        vim.list_extend(descriptors, { 'textobject', 'named node', 'Goto', 'Swap' })

        ---@param keymap table
        ---@return boolean
        local function keymap_filter(keymap)
            if keymap.desc ~= nil then
                for _, descriptor in ipairs(descriptors) do
                    if string.find(keymap.desc, descriptor) ~= nil then
                        return true
                    end
                end
            end
            return false
        end
        local keymap_opts = { modes = { 'n', 'x' }, filter = keymap_filter }
        map('th', utils.thunk(builtin.keymaps, keymap_opts), 'Show Keymaps')

        telescope.load_extension('fzf')
        telescope.load_extension('undo')
    end,
}
