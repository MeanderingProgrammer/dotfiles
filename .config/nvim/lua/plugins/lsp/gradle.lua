return {
    setup = function()
        require('lspconfig').gradle_ls.setup({
            filetypes = { 'kotlin', 'groovy' },
        })
    end,
}
