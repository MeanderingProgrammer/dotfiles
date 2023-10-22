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
            local lhs_filter = {}
            vim.list_extend(lhs_filter, { '<Up>', '<Down>', '<Left>', '<Right>' })
            vim.list_extend(lhs_filter, { '<C-H>', '<C-J>', '<C-K>', '<C-L>' })
            vim.list_extend(lhs_filter, { '<M-h>', '<M-j>', '<M-k>', '<M-l>' })
            vim.list_extend(lhs_filter, { '<F1>', '<F2>', '<F3>', '<F4>', '<F5>' })
            vim.list_extend(lhs_filter, { 'f', 'F', 't', 'T' })
            vim.list_extend(lhs_filter, { '<C-U>', '<C-D>', 'n', 'N', '<CR>', 'ii' })
            vim.list_extend(lhs_filter, { '<C-W>', 'y<C-G>', 'Y', '&', ';', ',', '*', '#' })
            if vim.tbl_contains(lhs_filter, keymap.lhs) then
                return false
            end

            local rhs_filters = { '<Plug>', '<SNR>' }
            for _, rhs_filter in ipairs(rhs_filters) do
                if keymap.rhs ~= nil and string.match(keymap.rhs, rhs_filter) then
                    return false
                end
            end

            return true
        end
        local keymap_options = {
            modes = { 'n', 'x' },
            show_plug = false,
            filter = keymap_filter,
        }
        map('<leader>th', builtin.keymaps, keymap_options, 'Show Keymaps')
    end,
}
