local utils = require('mp.lib.utils')

-- general
vim.o.backup = false
vim.o.clipboard = 'unnamedplus'
vim.o.swapfile = false
vim.o.undofile = true

-- ui
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.showmode = false
vim.o.sidescrolloff = 8
vim.o.signcolumn = 'yes'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.statuscolumn = '%s%=%{v:relnum?v:relnum:v:lnum} '
vim.o.termguicolors = true
vim.o.winborder = 'rounded'

-- editing
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.expandtab = true
vim.o.formatoptions = 'tqnl1j'
vim.o.ignorecase = true
vim.o.shiftwidth = 4
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = 4
vim.o.spelloptions = 'camel'
vim.o.tabstop = 4
vim.o.timeoutlen = 500
vim.o.updatetime = 250

-- ftplugin options
vim.api.nvim_create_autocmd('FileType', {
    group = utils.augroup('mp.options'),
    callback = function()
        vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
    end,
})
