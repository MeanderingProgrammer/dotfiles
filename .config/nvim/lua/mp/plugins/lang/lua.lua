local utils = require('mp.utils')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'lua', 'luadoc' },
        },
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            if not utils.is_android then
                table.insert(opts.install, 'lua-language-server')
                table.insert(opts.install, 'stylua')
            end
            opts.formatters.lua = { 'stylua' }
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            opts.servers.lua_ls = {
                settings = {
                    Lua = {
                        hint = { enable = true },
                    },
                },
            }
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
        'saghen/blink.cmp',
        opts = {
            providers = {
                lsp = { fallback_for = { 'lazydev' } },
                lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink' },
            },
        },
    },
}
