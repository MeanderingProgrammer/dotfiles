return {
    'numToStr/FTerm.nvim',
    config = function()
        local fterm = require('FTerm')
        fterm.setup({})

        local map_opts = { silent = true, desc = 'FTerm: Toggle' }
        vim.keymap.set({ 'n', 't' }, '<A-t>', fterm.toggle, map_opts)
        vim.keymap.set('t', '<esc>', fterm.toggle, map_opts)
    end,
}
