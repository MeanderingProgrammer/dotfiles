return {
    {
        'nvim-treesitter/nvim-treesitter',
        ---@type mp.ts.Config
        opts = {
            c = { install = true },
            c_sharp = { install = true },
            cmake = { install = true },
            cpp = { install = true },
            make = { install = true },
        },
    },
    {
        'mason-org/mason.nvim',
        ---@type mp.mason.Config
        opts = {
            clangd = { install = vim.g.computer },
            ['csharp-language-server'] = { install = vim.g.has.dotnet },
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            clangd = {},
            csharp_ls = {},
        },
    },
}
