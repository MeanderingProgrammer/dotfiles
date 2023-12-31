return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        vim.keymap.set('n', '<leader>nt', '<cmd>NvimTreeToggle<cr>', { desc = 'NvimTree: Toggle file tree' })

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
                exclude = { 'sample.txt', 'puzzle.md', 'dnd.md', 'general.md' },
            },
            tab = {
                sync = {
                    open = true,
                    close = true,
                },
            },
        })
    end,
}
