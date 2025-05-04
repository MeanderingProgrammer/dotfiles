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
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    spec = {
        { import = 'mp.plugins' },
        { import = 'mp.plugins.lang' },
    },
    dev = {
        path = function(plugin)
            local name = plugin.name
            local directories = { 'personal', 'open-source', 'neovim-plugins' }
            for _, directory in ipairs(directories) do
                local path = vim.fs.joinpath('~/dev/repos', directory, name)
                if require('mp.util').exists(path) then
                    return path
                end
            end
            error(('could not find: %s'):format(name))
        end,
    },
    change_detection = { notify = false },
})
