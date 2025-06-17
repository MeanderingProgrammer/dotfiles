---@alias mp.mason.Config table<string, mp.mason.Tool>

---@class mp.mason.Tool: mp.install.Tool

return {
    'mason-org/mason.nvim',
    dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    ---@type mp.mason.Config
    opts = {},
    ---@param opts mp.mason.Config
    config = function(_, opts)
        require('mason').setup({})

        local install = require('mp.util').tool.install(opts)

        require('mason-tool-installer').setup({
            ensure_installed = install,
        })
    end,
}
