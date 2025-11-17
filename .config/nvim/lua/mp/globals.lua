-- set leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- device information
vim.g.pc = vim.fn.has('android') == 0

-- dependency information
vim.g.has = {
    cargo = vim.fn.executable('cargo') == 1,
    dotnet = vim.fn.executable('dotnet') == 1,
    elixir = vim.fn.executable('elixir') == 1,
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

-- disable default providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- disable python ftplugin keymaps
vim.g.no_python_maps = true
