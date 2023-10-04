return {
    'numToStr/FTerm.nvim',
    keys = {
        { '<A-i>', '<cmd>lua require("FTerm").toggle()<cr>', mode = 'n', desc = 'FTerm: Toggle' },
        { '<A-i>', '<esc><cmd>lua require("FTerm").toggle()<cr>', mode = 't', desc = 'FTerm: Toggle' },
    },
    config = function()
        require('FTerm').setup({})
    end,
}
