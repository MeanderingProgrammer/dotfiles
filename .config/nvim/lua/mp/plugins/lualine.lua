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
        require('lualine').setup({
            sections = {
                lualine_x = { lsp_clients, 'filetype' },
            },
            extensions = { 'nvim-tree' },
        })
    end,
}
