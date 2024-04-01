return {
    'echasnovski/mini.nvim',
    config = function()
        local jump2d = require('mini.jump2d')
        jump2d.setup({
            spotter = jump2d.builtin_opts.word_start.spotter,
            allowed_windows = {
                not_current = false,
            },
            mappings = {
                start_jumping = '<tab>',
            },
        })
    end,
}
