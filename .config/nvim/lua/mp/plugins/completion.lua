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
            cmp.setup({
                sources = cmp.config.sources(opts.sources),
                window = {
                    completion = cmp.config.window.bordered({
                        border = 'rounded',
                    }),
                    documentation = cmp.config.window.bordered({
                        border = 'rounded',
                    }),
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
                sources = cmp.config.sources(
                    { { name = 'path' } },
                    { { name = 'cmdline' } }
                ),
            })
        end,
    },
    {
        'saghen/blink.cmp',
        enabled = not vim.g.cmp,
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
                    ['<C-space>'] = {
                        'show',
                        'show_documentation',
                        'hide_documentation',
                    },
                    ['<C-e>'] = { 'hide', 'fallback' },
                    ['<C-n>'] = { 'select_next', 'fallback' },
                    ['<C-p>'] = { 'select_prev', 'fallback' },
                    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
                    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
                    ['<tab>'] = { 'snippet_forward', 'fallback' },
                    ['<S-tab>'] = { 'snippet_backward', 'fallback' },
                },
                completion = {
                    trigger = {
                        show_on_blocked_trigger_characters = {},
                    },
                    menu = {
                        max_height = 20,
                    },
                    documentation = {
                        auto_show = true,
                        window = {
                            max_height = 40,
                        },
                    },
                    ghost_text = { enabled = true },
                },
                sources = {
                    default = vim.tbl_keys(opts.providers),
                    providers = opts.providers,
                },
            })
        end,
    },
}
