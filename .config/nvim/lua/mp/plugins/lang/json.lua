return {
    {
        'nvim-treesitter/nvim-treesitter',
        ---@type mp.ts.Config
        opts = {
            jq = { install = true },
            json = { install = true },
            json5 = { install = true },
            jsonc = { install = true },
        },
    },
    {
        'mason-org/mason.nvim',
        ---@type mp.mason.Config
        opts = {
            ['json-lsp'] = { install = vim.g.has.npm },
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            jsonls = {},
        },
    },
}
