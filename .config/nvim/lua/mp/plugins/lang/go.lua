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
            ['gopls'] = { install = vim.g.has.go },
            ['goimports'] = { install = vim.g.has.go },
            ['gofumpt'] = { install = vim.g.has.go },
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
