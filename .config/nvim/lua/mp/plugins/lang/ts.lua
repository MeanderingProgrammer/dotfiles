return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            local ts_grammars = { 'css', 'html', 'javascript', 'jsdoc', 'scss', 'svelte', 'typescript', 'vue' }
            vim.list_extend(opts.ensure_installed, ts_grammars)
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            servers = {
                eslint = {},
                svelte = {},
                tailwindcss = {},
                tsserver = {},
            },
        },
    },
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                svelte = { 'prettier' },
                typescript = { 'prettier' },
            },
        },
    },
}
