local config = vim.diagnostic.config

config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        },
    },
    virtual_text = { prefix = '●' },
})

vim.keymap.set('n', '<leader>d', function()
    if config().virtual_lines then
        config({ virtual_lines = false })
    else
        config({ virtual_lines = { current_line = true } })
    end
end, { noremap = true, silent = true })
