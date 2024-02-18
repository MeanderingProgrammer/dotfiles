return {
    'numToStr/FTerm.nvim',
    config = function()
        local fterm = require('FTerm')
        fterm.setup({})

        ---@param modes string|string[]
        ---@param lhs string
        local function toggle(modes, lhs)
            vim.keymap.set(modes, lhs, fterm.toggle, {
                silent = true,
                desc = 'FTerm: Toggle',
            })
        end
        toggle({ 'n', 't' }, '<A-t>')
        toggle('t', '<esc>')
    end,
}
