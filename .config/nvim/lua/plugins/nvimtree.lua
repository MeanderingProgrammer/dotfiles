return {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    keys = {
        { '<leader>t', '<cmd>NvimTreeToggle<cr>', desc = 'NvimTree: Toggle file tree' },
    },
    config = function()
        require('nvim-tree').setup({
            hijack_cursor = true,
            renderer = {
                group_empty = true,
                root_folder_label = function(path)
                    return vim.fn.fnamemodify(path, ':t')
                end,
            },
            filters = {
                git_ignored = false,
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
