---@module 'lspconfig'

---@type vim.lsp.Config
return {
    ---@type lspconfig.settings.rust_analyzer
    settings = {
        ['rust-analyzer'] = {
            check = { command = 'clippy' },
            diagnostics = { disabled = { 'inactive-code' } },
        },
    },
}
