return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
        local wk = require('which-key')
        -- (gc & gcc) / (gb & gbc) have the same prefix so overlap
        -- according to which-key, this is not really a problem
        wk.setup({
            plugins = {
                presets = {
                    operators = false,
                    motions = false,
                    windows = false,
                    nav = false,
                },
            },
            ignore_missing = true,
        })
        wk.register({
            ['<leader>'] = {
                name = 'leader',
                ww = { wk.show, 'Show WhichKey' },
            },
        })
    end,
}
