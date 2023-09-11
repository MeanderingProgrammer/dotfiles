return {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        require('indent_blankline').setup({
            show_trailing_blankline_indent = false,
        })
    end,
}
