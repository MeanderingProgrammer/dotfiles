local Keymap = require('mp.keymap')
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

    local offset = 0
    for _, pattern in ipairs({ '%-', '%d+%.' }) do
        local match = current:match('^%s*' .. pattern .. '%s*')
        local length = match and #match or 0
        offset = math.max(offset, length)
    end

    local lines = { '' }
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

---@param title string
---@param filetype string
---@param lines string[]
local function open_float(title, filetype, lines)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    Keymap.new({ buffer = buf, silent = true })
        :n('q', ':q<CR>')
        :n('<Esc>', ':q<CR>')

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

vim.api.nvim_create_user_command('Messages', function()
    local lines = utils.split(utils.exec('messages'), '\n')
    open_float('Messages', 'log', lines)
end, {})

vim.api.nvim_create_user_command('LspConfig', function()
    local buf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = buf })
    if #clients == 0 then
        vim.print('no active LSP found')
        return
    end
    local lines = {}
    for _, client in ipairs(clients) do
        local config = { name = client.name }
        local client_config = client.config ---@type table<string, any>
        for key, value in pairs(client_config) do
            local skip = vim.list_contains({ 'capabilities', 'name' }, key)
                or vim.list_contains({ 'function' }, type(value))
            if not skip then
                config[key] = value
            end
        end
        vim.list_extend(lines, utils.split(vim.inspect(config), '\n'))
    end

    open_float('LSP configuration', 'lua', lines)
end, { desc = 'show LSP configuration in a floating window' })
