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
        ---@param command string
        ---@param desc string
        local function map(char, command, desc)
            local lhs = ('<leader>t%s'):format(char)
            local rhs = ('<cmd>%s<cr>'):format(command)
            vim.keymap.set('n', lhs, rhs, { desc = desc })
        end
        map('l', 'Trouble lsp toggle', 'lsp')
        map('s', 'Trouble symbols toggle', 'symbols')
        map('x', 'Trouble diagnostics toggle', 'diagnostics')
        map('X', 'Trouble diagnostics toggle filter.buf=0', 'buf diagnostics')
    end,
}
