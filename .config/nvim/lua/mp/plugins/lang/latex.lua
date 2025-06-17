return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'latex' },
        },
    },
    {
        'mason-org/mason.nvim',
        ---@type mp.mason.Config
        opts = {
            texlab = { install = vim.g.computer },
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            texlab = {},
        },
    },
}
