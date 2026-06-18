---@module 'lspconfig'

---@type vim.lsp.Config
return {
    ---@type lspconfig.settings.gopls
    settings = {
        gopls = {
            gofumpt = true,
            codelenses = {
                test = true,
            },
            staticcheck = true,
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
}
