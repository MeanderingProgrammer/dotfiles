-- Disable comment continuation, needs to be autocmd to override ftplugin
vim.api.nvim_create_autocmd('BufEnter', {
    group = vim.api.nvim_create_augroup('CommentOpt', { clear = true }),
    callback = function()
        vim.opt.formatoptions:remove({ 'r', 'o' })
    end,
})

-- Sort spell file after adding words
vim.api.nvim_create_user_command('SortSpellFile', function()
    local file = vim.fn.stdpath('config') .. '/spell/en.utf-8.add'
    vim.cmd('edit ' .. file)
    local words = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    table.sort(words, function(a, b)
        if a:lower() == b:lower() then
            return a > b
        else
            return a:lower() < b:lower()
        end
    end)
    vim.api.nvim_buf_set_lines(0, 0, -1, false, words)
    vim.cmd('w')
    vim.cmd('mkspell! %')
    vim.cmd('bd')
end, {})
