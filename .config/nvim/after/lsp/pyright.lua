---@module 'lspconfig'

---@type vim.lsp.Config
return {
    ---@type lspconfig.settings.pyright
    settings = {
        python = {
            analysis = {
                diagnosticMode = 'workspace',
            },
        },
    },
}
