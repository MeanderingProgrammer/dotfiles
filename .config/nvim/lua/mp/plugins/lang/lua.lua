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
            local servers = utils.is_android and opts.system or opts.mason
            servers.lua_ls = {
                settings = {
                    Lua = {
                        hint = { enable = true },
                    },
                },
            }
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            if not utils.is_android then
                vim.list_extend(opts.ensure_installed, { 'stylua' })
            end
            opts.formatters.lua = { 'stylua' }
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
    { 'Bilal2453/luvit-meta', lazy = true }, -- vim.uv types
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
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
