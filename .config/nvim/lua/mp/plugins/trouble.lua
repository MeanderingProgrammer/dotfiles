return {
    'folke/trouble.nvim',
    dependencies = { 'echasnovski/mini.nvim' },
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('trouble').setup({
            modes = {
                lsp = {
                    focus = false,
                    win = { position = 'bottom', size = 15 },
                },
                symbols = {
                    focus = false,
                    win = { position = 'bottom', size = 15 },
                },
                diagnostics = {
                    focus = true,
                    win = { type = 'float' },
                },
            },
        })

        ---@param lhs string
        ---@param rhs string
        ---@param desc string
        local function map(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { desc = desc })
        end
        map('<leader>tl', '<cmd>Trouble lsp toggle<cr>', 'LSP')
        map('<leader>ts', '<cmd>Trouble symbols toggle<cr>', 'Symbols')
        map('<leader>tx', '<cmd>Trouble diagnostics toggle<cr>', 'Diagnostics')
        map('<leader>tX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', 'Buffer Diagnostics')
    end,
}
