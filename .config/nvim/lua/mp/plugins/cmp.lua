return {
    {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        config = function()
            local luasnip = require('luasnip')
            require('luasnip.loaders.from_vscode').lazy_load()
            luasnip.config.setup({})
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'saecki/crates.nvim',
            'saadparwaiz1/cmp_luasnip',
            'MeanderingProgrammer/py-requirements.nvim',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-path',
        },
        config = function()
            local cmp = require('cmp')
            local compare = require('cmp.config.compare')

            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = 'buffer' } },
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline({
                    ['<tab>'] = cmp.mapping.confirm({ select = false }),
                }),
                sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
            })

            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered({ border = 'rounded' }),
                    documentation = cmp.config.window.bordered({ border = 'rounded' }),
                },
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'crates' },
                    { name = 'py-requirements' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                }),
                mapping = cmp.mapping.preset.insert({
                    ['<cr>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-space>'] = cmp.mapping.complete(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                }),
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        compare.sort_text,
                        -- Below is default: https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua
                        compare.offset,
                        compare.exact,
                        compare.score,
                        compare.recently_used,
                        compare.locality,
                        compare.kind,
                        compare.length,
                        compare.order,
                    },
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
            })
        end,
    },
}
