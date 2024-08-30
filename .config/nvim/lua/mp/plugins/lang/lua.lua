return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'lua', 'luadoc' },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            opts.servers.lua_ls = {}
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = {
            formatters = {
                lua = { 'stylua' },
            },
        },
    },
    { 'Bilal2453/luvit-meta', lazy = true },
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- vim.uv typings from Bilal2453/luvit-meta
                'luvit-meta/library',
            },
        },
    },
    {
        'hrsh7th/nvim-cmp',
        opts = function(_, opts)
            table.insert(opts.sources, { name = 'lazydev', group_index = 0 })
        end,
    },
}
