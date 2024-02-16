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
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-path',
        },
        opts = {
            sources = {},
        },
        config = function(_, opts)
            local cmp = require('cmp')
            local compare = require('cmp.config.compare')

            vim.list_extend(opts.sources, {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
            })

            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered({ border = 'rounded' }),
                    documentation = cmp.config.window.bordered({ border = 'rounded' }),
                },
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },
                sources = cmp.config.sources(opts.sources),
                mapping = cmp.mapping.preset.insert({
                    ['<cr>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-space>'] = cmp.mapping.complete(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        -- Default: https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua
                        -- With sort_text added
                        compare.exact,
                        compare.score,
                        compare.sort_text,
                        compare.offset,
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
                experimental = {
                    ghost_text = true,
                },
            })

            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = 'buffer' } },
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
            })
        end,
    },
}
