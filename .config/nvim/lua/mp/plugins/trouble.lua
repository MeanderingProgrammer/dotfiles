return {
    'folke/trouble.nvim',
    dependencies = { 'echasnovski/mini.nvim' },
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('trouble').setup({
            keys = {
                ['<cr>'] = 'jump_close',
            },
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

        ---@param char string
        ---@param args string
        ---@param desc string
        local function map(char, args, desc)
            local lhs = string.format('<leader>t%s', char)
            local rhs = string.format('<cmd>Trouble %s<cr>', args)
            vim.keymap.set('n', lhs, rhs, { desc = desc })
        end
        map('l', 'lsp toggle', 'LSP')
        map('s', 'symbols toggle', 'Symbols')
        map('x', 'diagnostics toggle', 'Diagnostics')
        map('X', 'diagnostics toggle filter.buf=0', 'Buffer Diagnostics')
    end,
}
