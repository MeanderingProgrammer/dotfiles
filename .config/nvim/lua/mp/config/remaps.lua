---@param modes string|string[]
---@param lhs string
---@param rhs string
local function remap(modes, lhs, rhs)
    vim.keymap.set(modes, lhs, rhs, { noremap = true, silent = true })
end

-- Escape in terminal mode
remap('t', '<esc>', '<C-\\><C-n>')

-- Move lines up / down
remap('n', '<A-j>', '<cmd>m .+1<cr>==')
remap('n', '<A-k>', '<cmd>m .-2<cr>==')
remap('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi')
remap('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi')

-- Move split panes left / right
remap('n', '<A-h>', '<C-W>H')
remap('n', '<A-l>', '<C-W>L')

-- Move between panes
remap('n', '<C-h>', '<C-w>h')
remap('n', '<C-j>', '<C-w>j')
remap('n', '<C-k>', '<C-w>k')
remap('n', '<C-l>', '<C-w>l')

-- Moving by half page
remap('n', '<C-d>', '<C-d>zz')
remap('n', '<C-u>', '<C-u>zz')

-- Searching
remap('n', 'n', 'nzz')
remap('n', 'N', 'Nzz')
remap('n', '<cr>', ':noh<cr><cr>')

-- Escape
remap({ 'v', 'i' }, 'ii', '<esc>')

-- Remove my ability to fallback to arrows
remap({ 'n', 'v', 'i' }, '<Up>', '<Nop>')
remap({ 'n', 'v', 'i' }, '<Down>', '<Nop>')
remap({ 'n', 'v', 'i' }, '<Left>', '<Nop>')
remap({ 'n', 'v', 'i' }, '<Right>', '<Nop>')
