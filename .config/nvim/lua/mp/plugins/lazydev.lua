local utils = require('mp.utils')

return {
    'folke/lazydev.nvim',
    ft = 'lua',
    config = function()
        require('lazydev').setup({
            library = { '${3rd}/luv/library' },
            enabled = function()
                return not utils.in_root({ '.luarc.json' })
            end,
        })
    end,
}
