return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local hidden_files = { '.DS_Store' }
        vim.list_extend(hidden_files, require('mp.utils').hidden_directories())

        local oil = require('oil')
        oil.setup({
            keymaps = {
                -- Use telescope keymaps
                ['<C-v>'] = 'actions.select_vsplit',
                ['<C-x>'] = 'actions.select_split',
                -- Escape to close
                ['<esc>'] = 'actions.close',
                -- Disable navigation keymaps
                ['<C-h>'] = false,
                ['<C-l>'] = false,
            },
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name)
                    return vim.tbl_contains(hidden_files, name)
                end,
            },
            float = { padding = 10 },
        })

        require('which-key').register({
            ['<leader>'] = {
                o = { oil.toggle_float, 'Oil Toggle' },
            },
        })
    end,
}
