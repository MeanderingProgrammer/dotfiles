local opts = { noremap = true, silent = true }

-- Move lines up / down
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<cr>==', opts)
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<cr>==', opts)
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', opts)
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', opts)

-- Move split panes left / right
vim.keymap.set('n', '<A-h>', '<C-w>H', opts)
vim.keymap.set('n', '<A-l>', '<C-w>L', opts)

-- Move between panes
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Moving by half page
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Searching
vim.keymap.set('n', 'n', 'nzz', opts)
vim.keymap.set('n', 'N', 'Nzz', opts)
vim.keymap.set('n', '<cr>', ':noh<cr><cr>', opts)

-- Diagnostics
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

-- Execute current line
vim.keymap.set('n', '<leader>bb', function()
    vim.cmd(':! ' .. vim.fn.getline('.'))
end, opts)

-- Copy hex value of current character to clipboard
vim.keymap.set('n', '<leader>ff', function()
    local output = vim.api.nvim_exec2('ascii', { output = true }).output
    local encodings = vim.split(output, ',', { plain = true })
    if #encodings > 1 then
        local hex_info = vim.trim(encodings[#encodings - 1])
        local hex_code = vim.trim(vim.split(hex_info, ' ', { plain = true })[2])
        local result = vim.fn.trim(hex_code, '0', 1)
        vim.print(result)
        vim.fn.setreg('+', result)
    end
end, opts)

-- Remove ability to fallback to arrows
vim.keymap.set({ 'n', 'v', 'i' }, '<Up>', '<Nop>', opts)
vim.keymap.set({ 'n', 'v', 'i' }, '<Down>', '<Nop>', opts)
vim.keymap.set({ 'n', 'v', 'i' }, '<Left>', '<Nop>', opts)
vim.keymap.set({ 'n', 'v', 'i' }, '<Right>', '<Nop>', opts)
