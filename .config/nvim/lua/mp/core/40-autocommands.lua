local utils = require('mp.lib.utils')

vim.api.nvim_create_autocmd('FileType', {
    group = utils.augroup('options'),
    callback = function(args)
        vim.opt_local.formatoptions:remove({ 'c', 'o' })
        if utils.fold_comments(args.match) then
            vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.opt_local.foldmethod = 'expr'
        end
    end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
    group = utils.augroup('yank'),
    callback = function()
        vim.hl.on_yank()
    end,
})
