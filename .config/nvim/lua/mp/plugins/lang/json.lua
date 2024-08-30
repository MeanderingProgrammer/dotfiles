local utils = require('mp.utils')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'jq', 'json', 'json5', 'jsonc' },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            if utils.is_android then
                return
            end
            opts.mason.jsonls = {}
        end,
    },
}
