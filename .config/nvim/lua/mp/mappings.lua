local Keymap = require('mp.keymap')
local utils = require('mp.utils')

local map = Keymap.new({ noremap = true, silent = true })

-- move between panes
map:n('<C-h>', '<C-w>h')
map:n('<C-j>', '<C-w>j')
map:n('<C-k>', '<C-w>k')
map:n('<C-l>', '<C-w>l')

-- moving by half page
map:n('<C-d>', '<C-d>zz')
map:n('<C-u>', '<C-u>zz')

-- searching
map:n('n', 'nzz')
map:n('N', 'Nzz')
map:n('<CR>', ':noh<CR><CR>')

-- move split panes left / right
map:n('<A-h>', '<C-w>H')
map:n('<A-l>', '<C-w>L')

-- move lines up / down
map:n('<A-j>', '<Cmd>m .+1<CR>==')
map:n('<A-k>', '<Cmd>m .-2<CR>==')
map:i('<A-j>', '<Esc><Cmd>m .+1<CR>==gi')
map:i('<A-k>', '<Esc><Cmd>m .-2<CR>==gi')

map:n('<leader>bb', function()
    local cmd = vim.fn.getline('.')
    vim.print(('command: %s'):format(cmd))
    local out = vim.fn.system(cmd)
    vim.print(out)
end, 'execute current line')

map:n('<leader>hc', function()
    local values = {} ---@type table<string, string>
    local encodings = utils.split(utils.exec('ascii'), ',')
    for _, encoding in ipairs(encodings) do
        local parts = utils.split(encoding, ' ', true)
        values[parts[1]] = parts[2]
    end
    local hex = vim.fn.trim(values['Hex'], '0', 1)
    vim.print(hex)
    vim.fn.setreg('+', hex)
end, 'copy hex code of current character')

---@see lsp-defaults
vim.keymap.del('n', 'gra')
vim.keymap.del('n', 'gri')
vim.keymap.del('n', 'grn')
vim.keymap.del('n', 'grr')
