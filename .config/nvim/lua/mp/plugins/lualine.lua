return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local function lsp_clients()
            local buffer_clients = vim.lsp.get_active_clients({ bufnr = 0 })
            local clients = vim.tbl_map(function(client)
                return client.name
            end, buffer_clients)
            return vim.fn.join(clients, ' ')
        end
        local filename_section = { 'filename', path = 1 }
        require('lualine').setup({
            sections = {
                lualine_c = { filename_section },
                lualine_x = { lsp_clients, 'filetype' },
            },
            inactive_sections = {
                lualine_c = { filename_section },
            },
            extensions = { 'oil' },
        })
    end,
}
