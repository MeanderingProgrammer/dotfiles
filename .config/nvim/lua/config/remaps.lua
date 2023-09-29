-- Escape in terminal mode
vim.keymap.set('t', '<esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- Remove my ability to fallback to arrows
vim.keymap.set({ 'n', 'v', 'i' }, '<Up>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v', 'i' }, '<Down>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v', 'i' }, '<Left>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v', 'i' }, '<Right>', '<Nop>', { noremap = true, silent = true })
