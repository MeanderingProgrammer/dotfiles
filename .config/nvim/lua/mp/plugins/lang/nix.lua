local utils = require('mp.utils')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { languages = { 'nix' } },
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            if utils.is_mac then
                table.insert(opts.install, 'nil')
            end
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            if utils.is_mac then
                opts.servers.nil_ls = {}
            end
        end,
    },
}
