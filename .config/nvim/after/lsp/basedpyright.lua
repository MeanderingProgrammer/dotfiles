---@module 'lspconfig'

---@type vim.lsp.Config
return {
    ---@type lspconfig.settings.basedpyright
    settings = {
        basedpyright = {
            analysis = {
                diagnosticMode = vim.g.personal and 'workspace'
                    or 'openFilesOnly',
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
