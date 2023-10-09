local function remap(modes, lhs, rhs)
    vim.keymap.set(modes, lhs, rhs, { noremap = true, silent = true })
end

-- Escape in terminal mode
remap('t', '<esc>', '<C-\\><C-n>')

-- Move split panes
remap('n', '<A-h>', '<C-W>H')
remap('n', '<A-j>', '<C-W>J')
remap('n', '<A-k>', '<C-W>K')
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
