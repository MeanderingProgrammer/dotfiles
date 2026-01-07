local utils = require('mp.lib.utils')

vim.api.nvim_create_autocmd('FileType', {
    group = utils.augroup('options'),
    callback = function()
        vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
    end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
    group = utils.augroup('yank'),
    callback = function()
        vim.hl.on_yank()
    end,
})
