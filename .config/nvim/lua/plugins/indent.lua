return {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        require('indent_blankline').setup({
            use_treesitter = true,
            show_trailing_blankline_indent = false,
            filetype_exclude = { 'dashboard' },
        })
    end,
}
