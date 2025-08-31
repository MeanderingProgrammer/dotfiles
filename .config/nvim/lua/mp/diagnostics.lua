local Keymap = require('mp.keymap')

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
        source = 'if_many',
        prefix = '●',
    },
    float = {
        source = 'if_many',
        header = '',
    },
})

Keymap.new({ silent = true }):n('<leader>d', vim.diagnostic.open_float)
