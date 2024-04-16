return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local hidden_files = { '.DS_Store', '.git', '.idea', '.obsidian' }
        vim.list_extend(hidden_files, { '.gradle', '_build', 'target', 'node_modules' })
        vim.list_extend(hidden_files, { '__pycache__', '.pytest_cache', '.mypy_cache' })

        local oil = require('oil')
        oil.setup({
            -- Use telescope keymaps
            keymaps = {
                ['<C-v>'] = 'actions.select_vsplit',
                ['<C-x>'] = 'actions.select_split',
            },
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name)
                    return vim.tbl_contains(hidden_files, name)
                end,
            },
        })

        require('which-key').register({
            ['<leader>'] = {
                o = { oil.toggle_float, 'Oil Toggle' },
            },
        })
    end,
}
