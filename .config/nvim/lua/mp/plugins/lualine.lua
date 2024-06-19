return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local function buf_lsp_info()
            if vim.api.nvim_win_get_width(0) > 100 then
                local bufnr = vim.api.nvim_get_current_buf()
                return vim.iter(vim.lsp.get_clients({ bufnr = bufnr }))
                    :map(function(client)
                        return client.name
                    end)
                    :join(' ')
            else
                return ''
            end
        end
        local filename = { 'filename', path = 1, shorting_target = 100 }
        require('lualine').setup({
            sections = {
                lualine_c = { filename },
                lualine_x = { '%n', buf_lsp_info, 'filetype' },
            },
            inactive_sections = {
                lualine_c = { filename },
            },
            extensions = { 'oil' },
        })
    end,
}
