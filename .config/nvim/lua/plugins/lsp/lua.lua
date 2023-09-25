return {
    setup = function()
        require('lspconfig').lua_ls.setup({
            settings = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        })
    end,
}
