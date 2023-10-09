return {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        require('ibl').setup({
            exclude = { filetypes = { 'dashboard' } },
            scope = { enabled = false },
        })
    end,
}
