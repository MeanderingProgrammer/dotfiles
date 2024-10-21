local utils = require('mp.utils')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { languages = { 'terraform' } },
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            if not utils.is_android then
                table.insert(opts.install, 'terraform-ls')
            end
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            if not utils.is_android then
                opts.servers.terraformls = {}
            end
        end,
    },
}
