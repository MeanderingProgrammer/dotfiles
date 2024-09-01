local utils = require('mp.utils')

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
            (utils.is_android and opts.system or opts.mason).lua_ls = {}
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            local formatters = { 'stylua' }
            if not utils.is_android then
                vim.list_extend(opts.ensure_installed, formatters)
            end
            opts.formatters.lua = formatters
        end,
    },
    {
        'nvim-neotest/neotest',
        dependencies = { 'nvim-neotest/neotest-plenary' },
        opts = function(_, opts)
            vim.list_extend(opts.adapters, {
                require('neotest-plenary'),
            })
        end,
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
