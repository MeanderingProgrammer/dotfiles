return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
        local wk = require('which-key')
        ---@diagnostic disable-next-line: missing-fields
        wk.setup({
            plugins = {
                presets = {
                    operators = false,
                    motions = false,
                    windows = false,
                    nav = false,
                },
            },
            filter = function(mapping)
                return mapping.desc ~= nil and mapping.desc ~= ''
            end,
        })
        wk.add({
            { '<leader>', group = 'leader' },
            { '<leader>f', group = 'fzf' },
            { '<leader>h', group = 'harpoon' },
            { '<leader>m', group = 'markdown' },
            { '<leader>s', group = 'stashpad' },
            { '<leader>w', group = 'workspace' },
            { '<leader>y', group = 'yadm' },
        })
    end,
}
