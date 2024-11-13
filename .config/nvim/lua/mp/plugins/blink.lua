return {
    { 'saghen/blink.compat' },
    {
        'saghen/blink.cmp',
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
