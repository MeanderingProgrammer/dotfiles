---@type vim.lsp.Config
return {
    settings = {
        ['rust-analyzer'] = {
            check = { command = 'clippy' },
            diagnostics = { disabled = { 'inactive-code' } },
        },
    },
}
