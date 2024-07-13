---@param modes string|string[]
---@param lhs string
---@param rhs string|function
local function map(modes, lhs, rhs)
    vim.keymap.set(modes, lhs, rhs, { noremap = true, silent = true })
end

-- Move lines up / down
map('n', '<A-j>', '<cmd>m .+1<cr>==')
map('n', '<A-k>', '<cmd>m .-2<cr>==')
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi')
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi')

-- Move split panes left / right
map('n', '<A-h>', '<C-w>H')
map('n', '<A-l>', '<C-w>L')

-- Move between panes
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Moving by half page
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- Searching
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map('n', '<cr>', ':noh<cr><cr>')

-- Diagnostics
map('n', '<leader>d', vim.diagnostic.open_float)

-- Execute current line
map('n', '<leader>bb', function()
    vim.cmd(':! ' .. vim.fn.getline('.'))
end)

-- Copy hex value of current character to clipboard
map('n', '<leader>ff', function()
    local output = vim.api.nvim_exec2('ascii', { output = true }).output
    local encodings = vim.split(output, ',', { plain = true })
    if #encodings > 1 then
        local hex_info = vim.trim(encodings[#encodings - 1])
        local hex_code = vim.trim(vim.split(hex_info, ' ', { plain = true })[2])
        local result = vim.fn.trim(hex_code, '0', 1)
        vim.print(result)
        vim.fn.setreg('+', result)
    end
end)

-- Remove ability to fallback to arrows
map({ 'n', 'v', 'i' }, '<Up>', '<Nop>')
map({ 'n', 'v', 'i' }, '<Down>', '<Nop>')
map({ 'n', 'v', 'i' }, '<Left>', '<Nop>')
map({ 'n', 'v', 'i' }, '<Right>', '<Nop>')
