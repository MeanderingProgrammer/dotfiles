-- disable comment continuation, needs to be autocmd to override ftplugin
vim.api.nvim_create_autocmd('BufEnter', {
    group = vim.api.nvim_create_augroup('user.options', {}),
    callback = function()
        vim.opt.formatoptions:remove({ 'r', 'o' })
    end,
})

vim.api.nvim_create_user_command('AdventData', function(opts)
    local file = vim.api.nvim_buf_get_name(0)
    local name = vim.fn.fnamemodify(file, ':.')
    local parts = vim.split(name, '/', { plain = true, trimempty = true })
    local directory = vim.fs.joinpath('data', parts[1], parts[2])
    local input = #opts.fargs == 0 and 'data' or 'sample'
    local path = vim.fs.joinpath(directory, ('%s.txt'):format(input))
    vim.cmd.vsplit(path)
end, { nargs = '?' })

-- sort spell file after adding words
vim.api.nvim_create_user_command('MySortSpell', function()
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

-- split current line into multiple lines of width 80
vim.api.nvim_create_user_command('MyFormatLine', function()
    local row = vim.api.nvim_win_get_cursor(0)[1] - 1

    local current = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
    local words = vim.split(current, ' ', { plain = true })

    local offset = 0
    for _, pattern in ipairs({ '%-', '%d+%.' }) do
        local match = current:match('^%s*' .. pattern .. '%s*')
        offset = math.max(offset, match and #match or 0)
    end

    local lines = { '' }
    for _, word in ipairs(words) do
        lines[#lines] = lines[#lines] .. word .. ' '
        if #lines[#lines] > 80 then
            lines[#lines + 1] = (' '):rep(offset)
        end
    end

    local result = {}
    for _, line in ipairs(lines) do
        line = line:sub(1, #line - 1)
        if #line > 0 then
            result[#result + 1] = line
        end
    end

    vim.api.nvim_buf_set_lines(0, row, row + 1, false, result)
end, {})

---@param title string
---@param filetype string
---@param lines string[]
local function open_float(title, filetype, lines)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    ---@type vim.keymap.set.Opts
    local key_opts = { buffer = buf, noremap = true, silent = true }
    vim.keymap.set('n', 'q', ':q<CR>', key_opts)
    vim.keymap.set('n', '<Esc>', ':q<CR>', key_opts)

    local cols = vim.o.columns
    local rows = vim.api.nvim_win_get_height(0)
    local width = math.floor((cols * 0.75) + 0.5)
    local height = math.floor((rows * 0.90) + 0.5)
    local win = vim.api.nvim_open_win(buf, true, {
        col = math.floor((cols - width) / 2),
        row = math.floor((rows - height) / 2),
        width = width,
        height = height,
        relative = 'editor',
        title = (' %s '):format(title),
        title_pos = 'center',
    })

    ---@type vim.api.keyset.option
    local buf_opts = { buf = buf }
    vim.api.nvim_set_option_value('bufhidden', 'delete', buf_opts)
    vim.api.nvim_set_option_value('filetype', filetype, buf_opts)
    vim.api.nvim_set_option_value('modifiable', false, buf_opts)

    vim.api.nvim_create_autocmd('BufLeave', {
        buffer = buf,
        callback = function()
            vim.api.nvim_win_close(win, true)
        end,
    })
end

vim.api.nvim_create_user_command('MyMessages', function()
    local text = vim.api.nvim_exec2('messages', { output = true }).output
    local lines = vim.split(text, '\n', { plain = true })
    open_float('Messages', 'msglog', lines)
end, {})

-- show LSP configuration in a floating window
vim.api.nvim_create_user_command('MyLspConfig', function()
    local buf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = buf })
    if #clients == 0 then
        vim.print('no active LSP found')
        return
    end

    local lines = {}
    for _, client in ipairs(clients) do
        local config = { name = client.name }
        for key, value in pairs(client.config) do
            local skip = vim.tbl_contains({ 'capabilities', 'name' }, key)
                or vim.tbl_contains({ 'function' }, type(value))
            if not skip then
                config[key] = value
            end
        end
        local text = vim.inspect(config)
        vim.list_extend(lines, vim.split(text, '\n', { plain = true }))
    end

    open_float('LSP configuration', 'lua', lines)
end, {})
