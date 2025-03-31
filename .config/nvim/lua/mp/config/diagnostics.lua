---@param lhs string
---@param rhs function
local function map(lhs, rhs)
    vim.keymap.set('n', lhs, rhs, { noremap = true, silent = true })
end

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

map('<leader>d', function()
    if config().virtual_lines then
        config({ virtual_lines = false })
    else
        config({ virtual_lines = { current_line = true } })
    end
end)
