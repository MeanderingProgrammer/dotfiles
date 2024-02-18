return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
        local wk = require('which-key')
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
                w = { wk.show, 'Show WhichKey' },
            },
        })
    end,
}
