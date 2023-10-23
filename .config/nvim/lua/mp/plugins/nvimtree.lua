return {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    keys = {
        { '<leader>nt', '<cmd>NvimTreeToggle<cr>', desc = 'NvimTree: Toggle file tree' },
    },
    config = function()
        local size = 30
        require('nvim-tree').setup({
            hijack_cursor = true,
            view = {
                width = { min = size, max = size },
            },
            renderer = {
                group_empty = true,
                root_folder_label = function(path)
                    return vim.fn.fnamemodify(path, ':t')
                end,
            },
            filters = {
                custom = { '^.git$' },
                exclude = { 'dnd', 'general.md' },
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
