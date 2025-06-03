return {
    'echasnovski/mini.nvim',
    config = function()
        local icons = require('mini.icons')
        icons.setup({})
        -- TODO: only needed for lualine.nvim
        icons.mock_nvim_web_devicons()

        local jump2d = require('mini.jump2d')
        jump2d.setup({
            spotter = jump2d.builtin_opts.word_start.spotter,
            allowed_windows = {
                not_current = false,
            },
            mappings = {
                start_jumping = '<Tab>',
            },
        })

        require('mini.surround').setup({})
    end,
}
