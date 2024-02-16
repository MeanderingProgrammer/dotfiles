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
        local map = require('mp.config.utils').leader_map

        map('<leader>', builtin.buffers, 'Telescope: Find Existing Buffers')
        map('?', builtin.oldfiles, 'Telescope: Find Recently Opened Files')
        map('tf', builtin.find_files, 'Telescope: Find Files')
        map('tg', builtin.live_grep, 'Telescope: Grep Files')
        map('td', builtin.diagnostics, 'Telescope: Diagnostics')
        map('tw', builtin.grep_string, 'Telescope: Current Word')
        map('tt', builtin.help_tags, 'Telescope: Help Tags')

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
        local keymap_options = { modes = { 'n', 'x' }, filter = keymap_filter }
        map('th', builtin.keymaps, 'Telescope: Show Keymaps', keymap_options)

        telescope.load_extension('fzf')
        telescope.load_extension('undo')
    end,
}
