---@type vim.lsp.Config
return {
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
}
