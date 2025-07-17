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
            local rhs = ('<Cmd>Trouble %s<CR>'):format(command)
            vim.keymap.set('n', lhs, rhs, { desc = desc })
        end
        map('l', 'lsp toggle', 'lsp')
        map('s', 'symbols toggle', 'symbols')
        map('x', 'diagnostics toggle', 'workspace diagnostics')
        map('X', 'diagnostics toggle filter.buf=0', 'document diagnostics')
    end,
}
