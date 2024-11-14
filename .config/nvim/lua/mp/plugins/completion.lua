return {
    {
        'hrsh7th/nvim-cmp',
        enabled = vim.g.cmp,
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
        },
        opts = {
            sources = {
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
            },
        },
        config = function(_, opts)
            local cmp = require('cmp')
            local compare = require('cmp.config.compare')
            cmp.setup({
                sources = cmp.config.sources(opts.sources),
                window = {
                    completion = cmp.config.window.bordered({ border = 'rounded' }),
                    documentation = cmp.config.window.bordered({ border = 'rounded' }),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<cr>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<tab>'] = cmp.mapping(function(fallback)
                        if vim.snippet.active({ direction = 1 }) then
                            vim.snippet.jump(1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-tab>'] = cmp.mapping(function(fallback)
                        if vim.snippet.active({ direction = -1 }) then
                            vim.snippet.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        -- Default + sort_text: https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua
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
                        vim.snippet.expand(args.body)
                    end,
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
    {
        'saghen/blink.cmp',
        enabled = not vim.g.cmp,
        dependencies = { 'saghen/blink.compat' },
        version = 'v0.*',
        opts = {
            providers = {
                lsp = {},
                path = {},
                snippets = {},
                buffer = {},
            },
        },
        config = function(_, opts)
            require('blink.cmp').setup({
                keymap = {
                    ['<cr>'] = { 'accept', 'fallback' },
                    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                    ['<C-e>'] = { 'hide', 'fallback' },
                    ['<C-n>'] = { 'select_next', 'fallback' },
                    ['<C-p>'] = { 'select_prev', 'fallback' },
                    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
                    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
                    ['<tab>'] = { 'snippet_forward', 'fallback' },
                    ['<S-tab>'] = { 'snippet_backward', 'fallback' },
                },
                accept = {
                    auto_brackets = { enabled = true },
                },
                sources = {
                    completion = {
                        enabled_providers = vim.tbl_keys(opts.providers),
                    },
                    providers = opts.providers,
                },
                windows = {
                    autocomplete = {
                        max_height = 20,
                        border = 'rounded',
                        selection = 'auto_insert',
                    },
                    documentation = {
                        max_height = 40,
                        border = 'rounded',
                        auto_show = true,
                    },
                },
            })
        end,
    },
}
