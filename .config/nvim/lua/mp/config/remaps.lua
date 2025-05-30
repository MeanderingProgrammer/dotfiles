---@param modes string|string[]
---@param lhs string
---@param rhs string|function
local function map(modes, lhs, rhs)
    vim.keymap.set(modes, lhs, rhs, { noremap = true, silent = true })
end

-- move between panes
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- moving by half page
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- searching
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map('n', '<CR>', ':noh<CR><CR>')

-- move split panes left / right
map('n', '<A-h>', '<C-w>H')
map('n', '<A-l>', '<C-w>L')

-- move lines up / down
map('n', '<A-j>', '<Cmd>m .+1<CR>==')
map('n', '<A-k>', '<Cmd>m .-2<CR>==')
map('i', '<A-j>', '<Esc><Cmd>m .+1<CR>==gi')
map('i', '<A-k>', '<Esc><Cmd>m .-2<CR>==gi')

-- execute current line
map('n', '<leader>bb', function()
    vim.cmd(':! ' .. vim.fn.getline('.'))
end)

-- copy hex code of current character to clipboard
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

---@see lsp-defaults
vim.keymap.del('n', 'gra')
vim.keymap.del('n', 'gri')
vim.keymap.del('n', 'grn')
vim.keymap.del('n', 'grr')
