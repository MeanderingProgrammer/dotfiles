-- set leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- TODO: remove once flickering issue is resolved
-- https://github.com/neovim/neovim/issues/32660
vim.g._ts_force_sync_parsing = true

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

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- disable python ftplugin keymaps
vim.g.no_python_maps = true

-- disable default providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
