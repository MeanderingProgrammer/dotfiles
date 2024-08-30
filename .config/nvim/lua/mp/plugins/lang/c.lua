local utils = require('mp.utils')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'c', 'c_sharp', 'cmake', 'cpp', 'make' },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            if utils.is_android then
                return
            end
            opts.mason.clangd = {}
            opts.mason.csharp_ls = {}
        end,
    },
}
