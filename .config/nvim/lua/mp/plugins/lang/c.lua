return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'c', 'c_sharp', 'cmake', 'cpp', 'make' },
        },
    },
    {
        'mason-org/mason.nvim',
        ---@type mp.mason.Config
        opts = {
            clangd = { install = vim.g.computer },
            ['csharp-language-server'] = { install = vim.g.computer },
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            clangd = { enabled = vim.g.computer },
            csharp_ls = { enabled = vim.g.computer },
        },
    },
}
