return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'terraform' },
        },
    },
    {
        'mason-org/mason.nvim',
        ---@type mp.mason.Config
        opts = {
            ['terraform-ls'] = { install = vim.g.computer },
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            terraformls = { enabled = vim.g.computer },
        },
    },
}
