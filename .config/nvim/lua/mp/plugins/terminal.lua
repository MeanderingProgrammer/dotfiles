return {
    'numToStr/FTerm.nvim',
    config = function()
        local fterm = require('FTerm')
        ---@diagnostic disable-next-line: missing-fields
        fterm.setup({})

        ---@param mode string
        ---@param lhs string
        ---@param rhs function
        ---@param desc string
        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { desc = 'Fterm ' .. desc })
        end
        map('n', '<A-i>', fterm.toggle, 'Toggle')
        map('t', '<A-i>', fterm.exit, 'Exit')
        map('t', '<esc>', fterm.toggle, 'Toggle')
    end,
}
