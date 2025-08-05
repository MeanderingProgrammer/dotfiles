return {
    'numToStr/FTerm.nvim',
    config = function()
        local term = require('FTerm')
        ---@diagnostic disable-next-line: missing-fields
        term.setup({})

        ---@param mode string
        ---@param lhs string
        ---@param rhs function
        ---@param desc string
        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { desc = 'FTerm ' .. desc })
        end
        map('n', '<A-i>', term.toggle, 'toggle')
        map('t', '<A-i>', term.exit, 'exit')
        map('t', '<Esc>', term.toggle, 'toggle')
    end,
}
