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
            opts.servers.eslint = {}
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
}
