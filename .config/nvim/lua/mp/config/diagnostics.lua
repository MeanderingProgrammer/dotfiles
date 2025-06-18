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

---@type vim.keymap.set.Opts
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
