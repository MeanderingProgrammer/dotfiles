return {
    'numToStr/FTerm.nvim',
    config = function()
        local fterm = require('FTerm')
        fterm.setup({})

        require('which-key').register({
            ['<A-i>'] = { fterm.toggle, 'Fterm Toggle' },
        })
        require('which-key').register({
            ['<A-i>'] = { fterm.exit, 'Fterm Exit' },
            ['<esc>'] = { fterm.toggle, 'Fterm Toggle' },
        }, { mode = 't' })
    end,
}
