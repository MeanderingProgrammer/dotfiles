local Keymap = require('mp.lib.keymap')

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

Keymap.new({ prefix = '<leader>', silent = true })
    :n('d', vim.diagnostic.open_float)
    :n('D', function()
        vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    end, 'toggle diagnostics')
