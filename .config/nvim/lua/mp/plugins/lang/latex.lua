return {
    {
        'nvim-treesitter/nvim-treesitter',
        ---@type mp.ts.Config
        opts = {
            latex = { install = true },
        },
    },
    {
        'mason-org/mason.nvim',
        ---@type mp.mason.Config
        opts = {
            ['texlab'] = { install = vim.g.pc },
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
