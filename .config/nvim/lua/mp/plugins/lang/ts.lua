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
            opts.servers.tsserver = {
                settings = {
                    implicitProjectConfiguration = {
                        checkJs = true,
                    },
                },
            }
        end,
    },
    {
        'stevearc/conform.nvim',
        init = function()
            vim.env.PRETTIERD_LOCAL_PRETTIER_ONLY = 1
        end,
        opts = {
            formatters_by_ft = {
                javascript = { 'prettierd' },
                typescript = { 'prettierd' },
            },
        },
    },
    {
        'mfussenegger/nvim-lint',
        init = function()
            vim.env.ESLINT_D_LOCAL_ESLINT_ONLY = 1
        end,
        opts = {
            linters_by_ft = {
                javascript = { 'eslint_d' },
                typescript = { 'eslint_d' },
            },
        },
    },
}
