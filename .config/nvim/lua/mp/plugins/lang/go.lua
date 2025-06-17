return {
    {
        'nvim-treesitter/nvim-treesitter',
        ---@type mp.ts.Config
        opts = {
            go = { install = true },
            gomod = { install = true },
            gosum = { install = true },
            gowork = { install = true },
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
            gopls = {},
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
