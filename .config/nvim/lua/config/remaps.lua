-- Escape in terminal mode
vim.keymap.set('t', '<esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- Move split panes
vim.keymap.set('n', '<C-H>', '<C-W>H', { noremap = true, silent = true })
vim.keymap.set('n', '<C-J>', '<C-W>J', { noremap = true, silent = true })
vim.keymap.set('n', '<C-K>', '<C-W>K', { noremap = true, silent = true })
vim.keymap.set('n', '<C-L>', '<C-W>L', { noremap = true, silent = true })

-- Move between panes
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Various Escapes
vim.keymap.set({ 'v', 'i' }, 'ii', '<esc>', { noremap = true, silent = true })
vim.keymap.set({ 'v', 'i' }, 'jk', '<esc>', { noremap = true, silent = true })
vim.keymap.set({ 'v', 'i' }, 'kj', '<esc>', { noremap = true, silent = true })

-- Remove my ability to fallback to arrows
vim.keymap.set({ 'n', 'v', 'i' }, '<Up>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v', 'i' }, '<Down>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v', 'i' }, '<Left>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v', 'i' }, '<Right>', '<Nop>', { noremap = true, silent = true })
