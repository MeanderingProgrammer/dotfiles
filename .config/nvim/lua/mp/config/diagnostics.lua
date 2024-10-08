vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        },
    },
    virtual_text = {
        source = true,
        prefix = '●',
    },
    float = {
        source = true,
        border = 'rounded',
        header = '',
    },
})
