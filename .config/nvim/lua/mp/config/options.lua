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

-- Set wait time to complete mapping
vim.opt.timeoutlen = 1000

-- Save undo history
vim.opt.undofile = true

-- Split to right side by default
vim.opt.splitright = true

-- Better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- Indentation settings
vim.opt.smartindent = true

-- Tab / Space settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Keep some context in view
vim.opt.scrolloff = 8

-- Use system clipboard
vim.opt.clipboard = 'unnamedplus'
