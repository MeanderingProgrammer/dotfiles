return {
    {
        'nvim-treesitter/nvim-treesitter',
        ---@type mp.ts.Config
        opts = {
            lua = { install = true },
            luadoc = { install = true },
        },
    },
    {
        'mason-org/mason.nvim',
        ---@type mp.mason.Config
        opts = {
            ['lua-language-server'] = { install = vim.g.pc },
            ['selene'] = { install = vim.g.pc },
            ['stylua'] = { install = vim.g.pc },
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            lua_ls = {
                settings = {
                    Lua = {
                        hint = { enable = true },
                        runtime = { version = 'LuaJIT' },
                        diagnostics = {
                            ignoredFiles = 'Enable',
                            groupFileStatus = {
                                ['await'] = 'Any',
                                ['duplicate'] = 'Any',
                                ['luadoc'] = 'Any',
                                ['redefined'] = 'Any',
                                ['strong'] = 'Any',
                                ['type-check'] = 'Any',
                                ['unused'] = 'Any',
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
                    return require('mp.util').path.in_root({ 'selene.toml' })
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
                return not require('mp.util').path.in_root({ '.luarc.json' })
            end,
        },
    },
    {
        'saghen/blink.cmp',
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
