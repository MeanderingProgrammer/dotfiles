-- Remap space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

-- Line number settings
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation settings
vim.opt.smartindent  = true

-- Tab / Space settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Use system clipboard
vim.opt.clipboard = 'unnamedplus'

-- General key remaps
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Custom Commands
vim.api.nvim_create_user_command('Test', 'echo "Hello World"', { nargs = 0 })
