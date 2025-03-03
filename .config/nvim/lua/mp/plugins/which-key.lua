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
            { '<leader>c', group = 'crates' },
            { '<leader>f', group = 'fzf' },
            { '<leader>g', group = 'goto' },
            { '<leader>h', group = 'harpoon' },
            { '<leader>m', group = 'markdown' },
            { '<leader>r', group = 'requirements' },
            { '<leader>s', group = 'session' },
            { '<leader>t', group = 'trouble' },
            { '<leader>w', group = 'workspace' },
        })
    end,
}
