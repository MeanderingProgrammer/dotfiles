return {
    'nvim-mini/mini.nvim',
    config = function()
        local icons = require('mini.icons')
        icons.setup({})
        -- TODO: only needed for lualine.nvim
        icons.mock_nvim_web_devicons()

        local jump = require('mini.jump2d')
        jump.setup({
            spotter = jump.builtin_opts.word_start.spotter,
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
