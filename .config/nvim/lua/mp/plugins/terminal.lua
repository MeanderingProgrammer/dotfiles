local Keymap = require('mp.lib.keymap')

return {
    'numToStr/FTerm.nvim',
    config = function()
        local term = require('FTerm')
        ---@diagnostic disable-next-line: missing-fields
        term.setup({})

        Keymap.new({ group = 'FTerm' })
            :n('<A-i>', term.toggle, 'toggle')
            :t('<A-i>', term.exit, 'exit')
            :t('<Esc>', term.toggle, 'toggle')
    end,
}
