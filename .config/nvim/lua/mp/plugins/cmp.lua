return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
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
}
