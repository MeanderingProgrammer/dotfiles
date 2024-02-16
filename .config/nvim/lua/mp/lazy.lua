local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    spec = {
        { import = 'mp.plugins' },
        { import = 'mp.plugins.lang' },
        { import = 'mp.plugins.coding', cond = vim.fn.has('mac') == 1 },
    },
    ---@diagnostic disable-next-line: assign-type-mismatch
    dev = { path = '~/dev/repos' },
})
