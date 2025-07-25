-- remap space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- TODO: remove once flickering issue is resolved
-- https://github.com/neovim/neovim/issues/32660
vim.g._ts_force_sync_parsing = true

-- os information
vim.g.mac = vim.fn.has('mac') == 1
vim.g.linux = vim.fn.has('linux') == 1 or vim.fn.has('wsl') == 1

-- device information
vim.g.pc = vim.fn.has('android') == 0

-- dependency information
vim.g.has = {
    dotnet = vim.fn.executable('dotnet') == 1,
    gem = vim.fn.executable('gem') == 1,
    go = vim.fn.executable('go') == 1,
    npm = vim.fn.executable('npm') == 1,
    opam = vim.fn.executable('opam') == 1,
    pip = vim.fn.executable('pip') == 1,
}

-- use an opaque or transparent colorscheme
vim.g.opaque = true

-- disable python ftplugin keymaps
vim.g.no_python_maps = true

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- color
vim.opt.termguicolors = true

-- line number
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.statuscolumn = '%s%=%{v:relnum?v:relnum:v:lnum} '

-- mode is already in status line plugin
vim.opt.showmode = false

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- wait time to complete mapping
vim.opt.timeoutlen = 500

-- wait time for detecting changes
vim.opt.updatetime = 250

-- save / backup / undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- split to right / below by default
vim.opt.splitright = true
vim.opt.splitbelow = true

-- better completion experience
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- indentation
vim.opt.smartindent = true

-- tab / space
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- keep context in view
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- use system clipboard
vim.opt.clipboard = 'unnamedplus'

-- spell checking
vim.opt.spell = true

-- border style of floating windows
vim.opt.winborder = 'rounded'

-- disable default providers
for _, provider in ipairs({ 'python3', 'ruby', 'node', 'perl' }) do
    vim.g['loaded_' .. provider .. '_provider'] = 0
end
