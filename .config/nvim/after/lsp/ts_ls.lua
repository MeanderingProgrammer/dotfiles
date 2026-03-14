---@module 'lspconfig'

---@type vim.lsp.Config
return {
    ---@type lspconfig.settings.ts_ls
    settings = {
        implicitProjectConfiguration = { checkJs = true },
    },
}
