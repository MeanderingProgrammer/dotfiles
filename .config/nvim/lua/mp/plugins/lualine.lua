return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        ---@return string
        local function lsp_info()
            if vim.api.nvim_win_get_width(0) < 100 then
                return ''
            end
            return table.concat(require('mp.util').lsp_names(0), ' ')
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
