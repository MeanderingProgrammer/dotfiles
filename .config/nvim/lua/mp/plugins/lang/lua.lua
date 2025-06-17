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
        ---@type mp.mason.Config
        opts = {
            ['lua-language-server'] = { install = vim.g.computer },
            selene = { install = vim.g.computer },
            stylua = { install = vim.g.computer },
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            lua_ls = {
                enabled = true,
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
        'stevearc/conform.nvim',
        ---@type mp.conform.Config
        opts = {
            stylua = { filetypes = { 'lua' } },
        },
    },
    {
        'mfussenegger/nvim-lint',
        ---@type mp.lint.Config
        opts = {
            selene = {
                filetypes = { 'lua' },
                condition = function()
                    return util.in_root({ 'selene.toml' })
                end,
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
