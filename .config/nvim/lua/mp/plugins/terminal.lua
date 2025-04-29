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
            vim.keymap.set(mode, lhs, rhs, { desc = 'FTerm ' .. desc })
        end
        map('n', '<A-i>', fterm.toggle, 'toggle')
        map('t', '<A-i>', fterm.exit, 'exit')
        map('t', '<esc>', fterm.toggle, 'toggle')
    end,
}
