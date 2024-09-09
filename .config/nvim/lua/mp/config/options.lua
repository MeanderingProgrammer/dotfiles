-- Remap space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Color settings
vim.opt.termguicolors = true
vim.opt.cursorline = true

-- Line number settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.statuscolumn = '%s%=%{v:relnum?v:relnum:v:lnum} '

-- Mode is already in status line plugin
vim.opt.showmode = false

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Set wait time to complete mapping
vim.opt.timeoutlen = 500

-- Set wait time for detecting changes
vim.opt.updatetime = 250

-- Save / Backup / Undo settings
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- Split to right / below by default
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Better completion experience
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Indentation settings
vim.opt.smartindent = true

-- Tab / Space settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Keep some context in view
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Use system clipboard
vim.opt.clipboard = 'unnamedplus'

-- Disable default providers
for _, provider in ipairs({ 'python3', 'ruby', 'node', 'perl' }) do
    vim.g['loaded_' .. provider .. '_provider'] = 0
end

-- Disable comment continuation, needs to be autocmd to override ftplugin
vim.api.nvim_create_autocmd('BufEnter', {
    group = vim.api.nvim_create_augroup('CommentOpt', { clear = true }),
    callback = function()
        vim.opt.formatoptions:remove({ 'r', 'o' })
    end,
})
