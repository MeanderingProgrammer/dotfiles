---@type vim.lsp.Config
return {
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
