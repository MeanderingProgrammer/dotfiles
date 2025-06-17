return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'go', 'gomod', 'gosum', 'gowork' },
        },
    },
    {
        'mason-org/mason.nvim',
        ---@type mp.mason.Config
        opts = {
            gopls = { install = true },
            goimports = { install = true },
            gofumpt = { install = true },
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            gopls = { enabled = true },
        },
    },
    {
        'stevearc/conform.nvim',
        ---@type mp.conform.Config
        opts = {
            goimports = { filetypes = { 'go' } },
            gofumpt = { filetypes = { 'go' } },
        },
    },
}
