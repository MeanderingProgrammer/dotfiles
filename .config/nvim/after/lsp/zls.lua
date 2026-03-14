---@module 'lspconfig'

---@type vim.lsp.Config
return {
    ---@type lspconfig.settings.zls
    settings = {
        zls = {
            warn_style = true,
            skip_std_references = true,
        },
    },
}
