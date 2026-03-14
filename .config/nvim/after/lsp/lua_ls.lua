---@module 'lspconfig'

---@type vim.lsp.Config
return {
    ---@type lspconfig.settings.lua_ls
    settings = {
        Lua = {
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
            runtime = { version = 'LuaJIT' },
        },
    },
}
