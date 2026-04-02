return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'mason-org/mason.nvim',
        'mfussenegger/nvim-jdtls',
    },
    config = function()
        require('mp.configs.lsp')
    end,
}
