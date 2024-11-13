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
                keymap = 'enter',
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
                        selection = 'manual',
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
