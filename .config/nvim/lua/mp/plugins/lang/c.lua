return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            vim.list_extend(opts.languages, { 'c', 'cpp', 'c_sharp' })
            vim.list_extend(opts.languages, { 'cmake', 'make' })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            opts.servers.clangd = {}
            opts.servers.csharp_ls = {}
        end,
    },
    {
        'stevearc/conform.nvim',
        opts = function(_, opts)
            vim.list_extend(opts.disabled_fts, { 'c', 'cpp' })
        end,
    },
}
