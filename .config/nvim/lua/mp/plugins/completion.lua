return {
    'saghen/blink.cmp',
    version = '*',
    config = function()
        local fb = 'fallback'

        local providers = {
            lsp = {},
            path = {},
            snippets = {},
            buffer = {},
            omni = {},
        }

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
                default = vim.tbl_keys(providers),
                providers = providers,
            },
        })
    end,
}
