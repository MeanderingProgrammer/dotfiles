return {
    setup = function()
        require('lspconfig').bashls.setup({
            filetypes = { 'sh', 'zsh' },
        })
    end,
}
