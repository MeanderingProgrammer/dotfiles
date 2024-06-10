local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
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
    },
    dev = {
        path = function(plugin)
            local plugin_directory = '~/dev/repos/personal/'
            if not vim.startswith(plugin[1], 'MeanderingProgrammer') then
                plugin_directory = '~/dev/repos/open-source/nvim-plugins/'
            end
            return plugin_directory .. plugin.name
        end,
    },
    change_detection = { notify = false },
})
