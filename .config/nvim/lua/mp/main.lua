local utils = require('mp.utils')

require('mp.lang.bash')
require('mp.lang.c')
require('mp.lang.git')
require('mp.lang.go')
require('mp.lang.java')
require('mp.lang.json')
require('mp.lang.latex')
require('mp.lang.lua')
require('mp.lang.markdown')
require('mp.lang.ocaml')
require('mp.lang.parser')
require('mp.lang.python')
require('mp.lang.ruby')
require('mp.lang.rust')
require('mp.lang.terraform')
require('mp.lang.typescript')
require('mp.lang.vim')
require('mp.lang.zig')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        lazyrepo,
        lazypath,
    })
    assert(vim.v.shell_error == 0, 'failed to clone lazy.nvim')
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    spec = { import = 'mp.plugins' },
    dev = {
        ---@param plugin LazyPlugin
        ---@return string
        path = function(plugin)
            local name = plugin.name
            local directories = { 'personal', 'open-source', 'neovim-plugins' }
            for _, directory in ipairs(directories) do
                local path = vim.fs.joinpath('~/dev/repos', directory, name)
                if utils.exists(path) then
                    return path
                end
            end
            error(('could not find: %s'):format(name))
        end,
    },
    change_detection = { notify = false },
})
