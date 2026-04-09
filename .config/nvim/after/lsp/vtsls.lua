---@module 'lspconfig'

---@type vim.lsp.Config
return {
    ---@type lspconfig.settings.vtsls
    settings = {
        typescript = {
            updateImportsOnFileMove = { enabled = 'always' },
            inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'all' },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = true },
            },
        },
    },
}
