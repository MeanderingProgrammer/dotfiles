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
    local encodings = vim.api.nvim_exec2('ascii', { output = true }).output
    local hex_code = vim.iter(vim.split(encodings, ',', { plain = true }))
        :map(function(encoding)
            return vim.split(encoding, ' ', { plain = true, trimempty = true })
        end)
        :filter(function(encoding)
            return vim.tbl_contains(encoding, 'Hex')
        end)
        :map(function(encoding)
            return vim.fn.trim(encoding[#encoding], '0', 1)
        end)
        :next()
    vim.print(hex_code)
    vim.fn.setreg('+', hex_code)
end)

-- Remove ability to fallback to arrows
map({ 'n', 'v', 'i' }, '<Up>', '<Nop>')
map({ 'n', 'v', 'i' }, '<Down>', '<Nop>')
map({ 'n', 'v', 'i' }, '<Left>', '<Nop>')
map({ 'n', 'v', 'i' }, '<Right>', '<Nop>')
