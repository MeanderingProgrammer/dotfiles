local Float = require('mp.float')
local utils = require('mp.utils')

vim.api.nvim_create_user_command('AdventData', function()
    local file = vim.api.nvim_buf_get_name(0)
    local name = vim.fn.fnamemodify(file, ':.')
    local parts = utils.split(name, '/', true)
    local path = vim.fs.joinpath('data', parts[1], parts[2], 'data.txt')
    vim.cmd.vsplit(path)
end, { desc = 'open data.txt associated with problem' })

vim.api.nvim_create_user_command('SortSpell', function()
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
end, { desc = 'sort spell file after adding words' })

vim.api.nvim_create_user_command('FormatLine', function()
    local row = vim.api.nvim_win_get_cursor(0)[1] - 1

    local current = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
    local words = utils.split(current, ' ')

    local offsets = {} ---@type integer[]
    for _, pattern in ipairs({ '%-', '%d+%.' }) do
        local match = current:match('^%s*' .. pattern .. '%s*')
        offsets[#offsets + 1] = match and #match or 0
    end

    local lines = { '' }
    local offset = vim.fn.max(offsets)
    for _, word in ipairs(words) do
        lines[#lines] = lines[#lines] .. word .. ' '
        if #lines[#lines] > 80 then
            lines[#lines + 1] = (' '):rep(offset)
        end
    end

    local result = {} ---@type string[]
    for _, line in ipairs(lines) do
        line = line:sub(1, #line - 1)
        if #line > 0 then
            result[#result + 1] = line
        end
    end

    vim.api.nvim_buf_set_lines(0, row, row + 1, false, result)
end, { desc = 'split current line into multiple lines of width 80' })

vim.api.nvim_create_user_command('Messages', function()
    local lines = utils.split(utils.exec('messages'), '\n')
    Float.new('Messages', 'log'):lines(lines)
end, { desc = 'show message history' })

vim.api.nvim_create_user_command('LspConfig', function()
    local buf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = buf })
    if #clients == 0 then
        vim.print('no active LSP found')
        return
    end
    local lines = {} ---@type string[]
    for _, client in ipairs(clients) do
        local config = { name = client.name }
        local client_config = client.config ---@type table<string, any>
        for key, value in pairs(client_config) do
            local skip_key = vim.list_contains({ 'capabilities', 'name' }, key)
            local skip_value = vim.list_contains({ 'function' }, type(value))
            if not skip_key and not skip_value then
                config[key] = value
            end
        end
        vim.list_extend(lines, utils.split(vim.inspect(config), '\n'))
    end
    Float.new('LSP Configuration', 'lua'):lines(lines)
end, { desc = 'show LSP configuration' })
