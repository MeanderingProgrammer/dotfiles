---@module 'lspconfig'

---@type vim.lsp.Config
return {
    ---@type lspconfig.settings.ts_ls
    settings = {
        ['js/ts'] = {
            implicitProjectConfig = { checkJs = true },
        },
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
