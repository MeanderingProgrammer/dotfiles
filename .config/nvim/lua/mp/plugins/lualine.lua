return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local function buf_lsp_info()
            local bufnr = vim.api.nvim_get_current_buf()
            local clients = vim.lsp.get_clients({ bufnr = bufnr })
            local parts = {
                string.format('(%d)', bufnr),
                vim.iter(clients)
                    :map(function(client)
                        return client.name
                    end)
                    :join(' '),
            }
            return vim.fn.join(parts, ' ')
        end
        local filename_section = { 'filename', path = 1 }
        require('lualine').setup({
            sections = {
                lualine_c = { filename_section },
                lualine_x = { buf_lsp_info, 'filetype' },
            },
            inactive_sections = {
                lualine_c = { filename_section },
            },
            extensions = { 'oil' },
        })
    end,
}
