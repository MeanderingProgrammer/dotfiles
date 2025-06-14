local util = require('mp.util')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'lua', 'luadoc' },
        },
    },
    {
        'mason-org/mason.nvim',
        opts = {
            install = util.pc({ 'lua-language-server', 'selene', 'stylua' }),
            formatters = {
                lua = { 'stylua' },
            },
            linters = {
                lua = util.pc({ 'selene' }),
            },
            linter_conditions = {
                selene = util.pc(function()
                    return util.in_root({ 'selene.toml' })
                end),
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            lua_ls = {
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
            },
        },
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
            enabled = function()
                return not util.in_root({ '.luarc.json' })
            end,
        },
    },
    {
        'hrsh7th/nvim-cmp',
        optional = true,
        opts = function(_, opts)
            local source = { name = 'lazydev', group_index = 0 }
            opts.sources[#opts.sources + 1] = source
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
                    score_offset = 100,
                },
            },
        },
    },
}
