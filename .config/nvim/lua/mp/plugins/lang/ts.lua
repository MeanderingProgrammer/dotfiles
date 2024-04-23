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
        opts = function(_, opts)
            opts.servers.svelte = {}
            opts.servers.tailwindcss = {}
            opts.servers.tsserver = {}
        end,
    },
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                javascript = { 'prettierd' },
                typescript = { 'prettierd' },
            },
        },
    },
    {
        'mfussenegger/nvim-lint',
        opts = {
            linters_by_ft = {
                javascript = { 'eslint_d' },
                typescript = { 'eslint_d' },
            },
        },
    },
}
