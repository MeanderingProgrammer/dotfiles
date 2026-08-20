---@module 'lspconfig'

local utils = require('mp.lib.utils')

---@type vim.lsp.Config
return {
    root_markers = vim.list_extend(
        { 'pyrightconfig.json', 'uv.lock' },
        utils.python_root_markers
    ),
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
