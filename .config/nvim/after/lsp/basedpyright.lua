---@module 'lspconfig'

---@type vim.lsp.Config
return {
    ---@type lspconfig.settings.basedpyright
    settings = {
        basedpyright = {
            analysis = {
                diagnosticMode = 'workspace',
                diagnosticSeverityOverrides = {
                    reportAny = false,
                    reportExplicitAny = false,
                    reportMissingTypeStubs = false,
                    reportUnusedCallResult = false,
                },
            },
        },
    },
}
