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
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if vim.snippet.active({ direction = 1 }) then
                            vim.snippet.jump(1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
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
        version = '*',
        opts = {
            providers = {
                lsp = {},
                path = {},
                snippets = {},
                buffer = {},
            },
        },
        config = function(_, opts)
            local fb = 'fallback'
            require('blink.cmp').setup({
                keymap = {
                    ['<CR>'] = { 'accept', fb },
                    ['<Tab>'] = { 'snippet_forward', 'select_next', fb },
                    ['<S-Tab>'] = { 'snippet_backward', 'select_prev', fb },
                    ['<C-d>'] = { 'scroll_documentation_down', fb },
                    ['<C-u>'] = { 'scroll_documentation_up', fb },
                    -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                    -- ['<C-e>'] = { 'cancel', 'fallback' },
                    -- ['<C-y>'] = { 'select_and_accept' },
                    -- ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
                    -- ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
                    -- ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
                },
                completion = {
                    trigger = {
                        show_on_blocked_trigger_characters = {},
                    },
                    menu = { max_height = 20 },
                    documentation = {
                        auto_show = true,
                        window = { max_height = 40 },
                    },
                    ghost_text = { enabled = true },
                },
                cmdline = {
                    keymap = {
                        -- ['<Tab>'] = { 'show_and_insert', 'select_next' },
                        -- ['<S-Tab>'] = { 'show_and_insert', 'select_prev' },
                        -- ['<C-space>'] = { 'show', 'fallback' },
                        -- ['<C-e>'] = { 'cancel' },
                        -- ['<C-y>'] = { 'select_and_accept' },
                        -- ['<C-n>'] = { 'select_next', 'fallback' },
                        -- ['<C-p>'] = { 'select_prev', 'fallback' },
                    },
                    completion = {
                        list = { selection = { preselect = false } },
                        menu = { auto_show = true },
                    },
                },
                sources = {
                    default = vim.tbl_keys(opts.providers),
                    providers = opts.providers,
                },
            })
        end,
    },
}
