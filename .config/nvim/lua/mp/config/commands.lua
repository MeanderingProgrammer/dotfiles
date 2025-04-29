-- Disable comment continuation, needs to be autocmd to override ftplugin
vim.api.nvim_create_autocmd('BufEnter', {
    group = vim.api.nvim_create_augroup('CommentOpt', {}),
    callback = function()
        vim.opt.formatoptions:remove({ 'r', 'o' })
    end,
})

-- Sort spell file after adding words
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

-- Attempt to format current line to multiple lines of width 80
vim.api.nvim_create_user_command('MyFormatLine', function()
    local row = vim.api.nvim_win_get_cursor(0)[1] - 1

    local current_line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
    local words = vim.split(current_line, ' ', { plain = true })

    local offset = 0
    for _, list_pattern in ipairs({ '%-', '%d+%.' }) do
        list_pattern = '^%s*' .. list_pattern .. '%s*'
        local match = current_line:match(list_pattern)
        offset = math.max(offset, match ~= nil and #match or 0)
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

-- Show LSP configuration in a floating window
vim.api.nvim_create_user_command('MyLspConfig', function()
    local current = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = current })
    if #clients == 0 then
        vim.print('No LSP found')
        return
    end

    ---@param key string
    ---@param value any
    ---@return string[]
    local function process(key, value)
        local ignore_key = vim.tbl_contains({ 'capabilities', 'name' }, key)
        local ignore_type = vim.tbl_contains({ 'function' }, type(value))
        if ignore_key or ignore_type then
            return {}
        end
        if type(value) == 'table' then
            local keys = vim.tbl_keys(value)
            if #keys == 0 then
                return {}
            elseif #keys == 1 and value[1] ~= nil then
                value = value[1]
            end
        end
        local lines = ('%s = %s,'):format(key, vim.inspect(value))
        return vim.split(lines, '\n', { plain = true })
    end

    local lines = {}
    for _, client in ipairs(clients) do
        lines[#lines + 1] = '{'
        lines[#lines + 1] = ('  name = "%s",'):format(client.name)
        local keys = vim.tbl_keys(client.config)
        table.sort(keys)
        for _, key in ipairs(keys) do
            for _, line in ipairs(process(key, client.config[key])) do
                lines[#lines + 1] = ('  %s'):format(line)
            end
        end
        lines[#lines + 1] = '}'
    end

    local buf = vim.api.nvim_create_buf(false, true)
    local rows, cols = vim.o.lines, vim.o.columns
    local height, width = math.floor(rows * 0.90), math.floor(cols * 0.75)
    vim.api.nvim_open_win(buf, true, {
        title = ' LSP Configuration ',
        title_pos = 'center',
        border = 'rounded',
        relative = 'editor',
        height = height,
        width = width,
        row = math.floor((rows - height) / 2),
        col = math.floor((cols - width) / 2),
    })
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    vim.api.nvim_set_option_value('bufhidden', 'delete', { buf = buf })
    vim.api.nvim_set_option_value('filetype', 'lua', { buf = buf })
    vim.api.nvim_set_option_value('modifiable', false, { buf = buf })

    local opts = { buffer = buf, noremap = true, silent = true }
    vim.keymap.set('n', 'q', ':q<cr>', opts)
    vim.keymap.set('n', '<esc>', ':q<cr>', opts)
end, {})

vim.api.nvim_create_user_command('AdventData', function(opts)
    local file = vim.api.nvim_buf_get_name(0)
    local name = vim.fn.fnamemodify(file, ':.')
    local parts = vim.split(name, '/', { plain = true, trimempty = true })
    local directory = vim.fs.joinpath('data', parts[1], parts[2])
    local input = #opts.fargs == 0 and 'data' or 'sample'
    local path = vim.fs.joinpath(directory, ('%s.txt'):format(input))
    vim.cmd.vsplit(path)
end, { nargs = '?' })
