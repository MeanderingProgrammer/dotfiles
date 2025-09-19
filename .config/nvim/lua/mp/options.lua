-- color
vim.opt.termguicolors = true

-- line number
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.statuscolumn = '%s%=%{v:relnum?v:relnum:v:lnum} '

-- mode is in status line
vim.opt.showmode = false

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- wait time to complete mapping
vim.opt.timeoutlen = 500

-- wait time for detecting changes
vim.opt.updatetime = 250

-- backup / swap / undo
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true

-- split below / right by default
vim.opt.splitbelow = true
vim.opt.splitright = true

-- better completion experience
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- indentation
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- keep context in view
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- use system clipboard
vim.opt.clipboard = 'unnamedplus'

-- spell checking
vim.opt.spell = true

-- border style of floating windows
vim.opt.winborder = 'rounded'

vim.api.nvim_create_autocmd('BufEnter', {
    group = vim.api.nvim_create_augroup('mp.options', {}),
    callback = function()
        vim.opt.formatoptions:remove({ 'r', 'o' })
    end,
})
