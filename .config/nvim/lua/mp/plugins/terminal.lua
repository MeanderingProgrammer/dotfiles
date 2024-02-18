return {
    'numToStr/FTerm.nvim',
    config = function()
        local fterm = require('FTerm')
        fterm.setup({})

        ---@param mode string
        ---@param lhs string
        ---@param rhs fun()
        ---@param desc string
        local function toggle(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, {
                silent = true,
                desc = 'FTerm: ' .. desc,
            })
        end
        toggle('n', '<A-i>', fterm.toggle, 'Toggle')
        toggle('t', '<A-i>', fterm.exit, 'Exit')
        toggle('t', '<esc>', fterm.toggle, 'Toggle')
    end,
}
