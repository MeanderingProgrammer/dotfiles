local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    spec = {
        { import = 'mp.plugins' },
        { import = 'mp.plugins.lang' },
    },
    dev = {
        path = function(plugin)
            local my_plugin = plugin.url:find('MeanderingProgrammer', 1, true) ~= nil
            local directory = my_plugin and 'personal' or 'open-source/nvim-plugins'
            return string.format('~/dev/repos/%s/%s', directory, plugin.name)
        end,
    },
    change_detection = { notify = false },
})
