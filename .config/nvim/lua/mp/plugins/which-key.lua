return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
        local wk = require('which-key')
        -- gc & gcc have the same prefix so overlap according to which-key, this is not really a problem
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
            { '<leader>g', group = 'goto' },
            { '<leader>h', group = 'harpoon' },
            { '<leader>r', group = 'requirements' },
            { '<leader>s', group = 'session' },
            { '<leader>t', group = 'telescope' },
            { '<leader>w', group = 'workspaces' },
            { '<leader>x', group = 'trouble' },
            { '<leader>ww', wk.show, desc = 'Show WhichKey' },
        })
    end,
}
