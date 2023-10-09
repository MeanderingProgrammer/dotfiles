return {
    'stevearc/oil.nvim',
    enabled = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        vim.keymap.set('n', '-', '<cmd>Oil<cr>')
        require('oil').setup({
            view_options = { show_hidden = true },
        })
    end,
}
