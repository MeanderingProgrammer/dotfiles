local util = require('mp.util')

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'echasnovski/mini.nvim' },
    config = function()
        ---@return string
        local function lsp_info()
            local width = vim.api.nvim_win_get_width(0)
            local names = width < 100 and {} or util.lsp_names(0)
            return table.concat(names, ' ')
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
    end,
}
