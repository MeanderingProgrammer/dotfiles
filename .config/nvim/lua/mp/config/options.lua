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

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Set wait time to complete mapping
vim.opt.timeoutlen = 500

-- Set wait time for detecting changes
vim.opt.updatetime = 250

-- Save undo history
vim.opt.undofile = true

-- Split to right / below by default
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Better completion experience
vim.opt.completeopt = 'menu,menuone,noselect'

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

-- Use system clipboard / WSL fix
if vim.fn.has('wsl') == 1 then
    vim.g.clipboard = {
        name = 'WslClipboard',
        copy = {
            ['+'] = 'clip.exe',
            ['*'] = 'clip.exe',
        },
        paste = {
            ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
end
vim.opt.clipboard = 'unnamedplus'

-- Disable default providers
for _, provider in ipairs({ 'python3', 'ruby', 'node', 'perl' }) do
    vim.g['loaded_' .. provider .. '_provider'] = 0
end

-- Remove once just is natively supported: https://github.com/neovim/neovim/pull/25511
vim.filetype.add({
    filename = {
        ['justfile'] = 'just',
    },
})
