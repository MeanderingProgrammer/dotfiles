return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local function buf_lsp_info()
            local bufnr = vim.api.nvim_get_current_buf()
            return vim.iter(vim.lsp.get_clients({ bufnr = bufnr }))
                :map(function(client)
                    return client.name
                end)
                :join(' ')
        end
        local filename_section = { 'filename', path = 1 }
        require('lualine').setup({
            sections = {
                lualine_c = { filename_section },
                lualine_x = { '%n', buf_lsp_info, 'filetype' },
            },
            inactive_sections = {
                lualine_c = { filename_section },
            },
            extensions = { 'oil' },
        })
    end,
}
