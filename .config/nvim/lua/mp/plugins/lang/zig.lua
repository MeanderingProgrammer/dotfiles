return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'zig' },
        },
    },
    {
        'mason-org/mason.nvim',
        ---@type mp.mason.Config
        opts = {
            zls = { install = vim.g.computer },
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            zls = {},
        },
    },
}
