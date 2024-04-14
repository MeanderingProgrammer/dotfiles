return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local function buf_lsp_info()
            local bufnr = vim.api.nvim_get_current_buf()
            local buffer_part = string.format('(%d)', bufnr)

            local buffer_clients = vim.lsp.get_active_clients({ bufnr = bufnr })
            local clients = vim.tbl_map(function(client)
                return client.name
            end, buffer_clients)
            local clients_part = table.concat(clients, ' ')

            return table.concat({ buffer_part, clients_part }, ' ')
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
