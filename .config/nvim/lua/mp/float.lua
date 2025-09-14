local Keymap = require('mp.keymap')

---@class mp.Float
---@field private buf integer
---@field private win integer
local Float = {}
Float.__index = Float

---@param title string
---@param filetype string
---@param width? number
---@param height? number
---@return mp.Float
function Float.new(title, filetype, width, height)
    local self = setmetatable({}, Float)

    local cols = vim.o.columns
    width = math.floor((cols * (width or 0.75)) + 0.5)

    local rows = vim.api.nvim_win_get_height(0)
    height = math.floor((rows * (height or 0.90)) + 0.5)

    self.buf = vim.api.nvim_create_buf(false, true)
    self.win = vim.api.nvim_open_win(self.buf, true, {
        col = math.floor((cols - width) / 2),
        row = math.floor((rows - height) / 2),
        width = width,
        height = height,
        relative = 'editor',
        title = (' %s '):format(title),
        title_pos = 'center',
    })

    self:option('buf', 'bufhidden', 'delete')
    self:option('buf', 'filetype', filetype)

    Keymap.new({ buffer = self.buf, silent = true })
        :n('q', ':q<CR>')
        :n('<Esc>', ':q<CR>')

    vim.api.nvim_create_autocmd('BufLeave', {
        buffer = self.buf,
        callback = function()
            self:close()
        end,
    })

    return self
end

function Float:close()
    vim.api.nvim_win_close(self.win, true)
end

---@param kind 'buf'
---@param name string
---@param value any
function Float:option(kind, name, value)
    if kind == 'buf' then
        vim.api.nvim_set_option_value(name, value, { buf = self.buf })
    end
end

---@param lines string[]
function Float:lines(lines)
    vim.api.nvim_buf_set_lines(self.buf, 0, -1, false, lines)
end

return Float
