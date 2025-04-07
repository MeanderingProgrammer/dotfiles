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
            if not vim.g.android then
                opts.install[#opts.install + 1] = 'lua-language-server'
                opts.install[#opts.install + 1] = 'stylua'
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
                        runtime = { version = 'LuaJIT' },
                        diagnostics = {
                            ignoredFiles = 'Enable',
                            groupFileStatus = {
                                ambiguity = 'Any',
                                await = 'Any',
                                duplicate = 'Any',
                                global = 'Any',
                                luadoc = 'Any',
                                redefined = 'Any',
                                strict = 'Any',
                                ['type-check'] = 'Any',
                                unbalanced = 'Any',
                                unused = 'Any',
                            },
                        },
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
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = { '${3rd}/luv/library' },
        },
    },
    {
        'hrsh7th/nvim-cmp',
        optional = true,
        opts = function(_, opts)
            opts.sources[#opts.sources + 1] = { name = 'lazydev', group_index = 0 }
        end,
    },
    {
        'saghen/blink.cmp',
        optional = true,
        opts = {
            providers = {
                lazydev = {
                    name = 'LazyDev',
                    module = 'lazydev.integrations.blink',
                    fallbacks = { 'lsp' },
                },
            },
        },
    },
}
