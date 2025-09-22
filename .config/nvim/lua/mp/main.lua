local utils = require('mp.lib.utils')

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
require('mp.lang.typst')
require('mp.lang.vim')
require('mp.lang.zig')

local lazypath = utils.path('data', 'lazy', 'lazy.nvim')
if not vim.uv.fs_stat(lazypath) then
    utils.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

---@type LazyConfig
local config = {
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
            error(('missing: %s'):format(name))
        end,
    },
    change_detection = { notify = false },
}

require('lazy').setup(config)
