return {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local size = 30
        require('nvim-tree').setup({
            hijack_cursor = true,
            view = {
                number = true,
                relativenumber = true,
                width = { min = size, max = size },
            },
            renderer = {
                group_empty = true,
                root_folder_label = function(path)
                    return vim.fn.fnamemodify(path, ':t')
                end,
            },
            filters = {
                custom = { '^.git$', '^__pycache__$', '^.mypy_cache$' },
                exclude = { '^.*.txt$', '^.*.md$' },
            },
            tab = {
                sync = { open = true, close = true },
            },
        })

        local api = require('nvim-tree.api')
        vim.keymap.set('n', '<leader>nt', api.tree.toggle, {
            silent = true,
            desc = 'NvimTree: Toggle File Tree',
        })
    end,
}
