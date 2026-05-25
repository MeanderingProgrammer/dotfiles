local utils = require('mp.lib.utils')

---@return string
local function lsp_info()
    local width = vim.api.nvim_win_get_width(0)
    local clients = width < 100 and {} or utils.lsp_names(0)
    return table.concat(clients, ' ')
end

local filename = { 'filename', path = 1, shorting_target = 100 }
require('lualine').setup({
    sections = {
        lualine_c = { filename },
        lualine_x = { '%n', lsp_info, 'filetype' },
    },
    inactive_sections = {
        lualine_c = { filename },
    },
    extensions = { 'oil' },
})
