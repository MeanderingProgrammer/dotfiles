local Float = require('mp.lib.float')
local utils = require('mp.lib.utils')

vim.api.nvim_create_user_command('AdventData', function()
    local file = vim.api.nvim_buf_get_name(0)
    local name = vim.fn.fnamemodify(file, ':.')
    local year, day = unpack(utils.split(name, '/'))
    local path = vim.fs.joinpath('data', year, day, 'data.txt')
    if utils.exists(path) then
        vim.cmd.vsplit(path)
    end
end, { desc = 'open data.txt associated with problem' })

vim.api.nvim_create_user_command('FormatLine', function()
    local row = vim.api.nvim_win_get_cursor(0)[1] - 1
    local current = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]

    local indent = 0
    for _, pattern in ipairs({ '%-', '%d+%.' }) do
        local match = current:match('^%s*' .. pattern .. '%s*')
        local length = match and #match or 0
        indent = length > indent and length or indent
    end

    local lines = { '' } ---@type string[]
    for _, word in ipairs(utils.split(current, ' ')) do
        if #lines[#lines] >= 80 then
            lines[#lines + 1] = (' '):rep(indent)
        end
        lines[#lines] = lines[#lines] .. word .. ' '
    end
    for i, line in ipairs(lines) do
        line = line:sub(1, #line - 1)
        assert(#line > 0, ('blank line %d'):format(i))
        lines[i] = line
    end

    vim.api.nvim_buf_set_lines(0, row, row + 1, false, lines)
end, { desc = 'split current line into multiple lines of width 80' })

vim.api.nvim_create_user_command('LspConfig', function()
    local buf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = buf })
    if #clients == 0 then
        vim.print('no active LSP found')
        return
    end
    local lines = {} ---@type string[]
    for _, client in ipairs(clients) do
        local config = vim.deepcopy(client.config)
        config.name = client.name
        config.capabilities = nil
        vim.list_extend(lines, utils.split(vim.inspect(config), '\n'))
    end
    Float.new('LSP Configuration', 'lua'):lines(lines)
end, { desc = 'show LSP configuration' })

vim.api.nvim_create_user_command('Messages', function()
    local messages = utils.exec('messages')
    local lines = utils.split(messages, '\n')
    Float.new('Messages', 'log'):lines(lines)
end, { desc = 'show message history' })

vim.api.nvim_create_user_command('SpellSort', function()
    local file = utils.path('config', 'spell', 'en.utf-8.add')
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

vim.api.nvim_create_user_command('SpellToggle', function()
    vim.o.spell = not vim.o.spell
end, { desc = 'toggle spell option' })
