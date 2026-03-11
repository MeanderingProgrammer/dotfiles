---@type vim.lsp.Config
return {
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
