local utils = require('mp.utils')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { languages = { 'zig' } },
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            if not utils.is_android then
                table.insert(opts.install, 'zls')
            end
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            if not utils.is_android then
                opts.servers.zls = {}
            end
        end,
    },
}
