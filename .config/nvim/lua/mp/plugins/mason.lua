local lang = require('mp.lib.lang')

---@class mp.mason.Package
---@field [1] string
---@field version? string

return {
    'mason-org/mason.nvim',
    dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    config = function()
        local configs = lang.tools()
        local packages = {} ---@type mp.mason.Package[]
        for name, config in pairs(configs) do
            packages[#packages + 1] = { name, version = config.version }
        end

        require('mason').setup({})
        require('mason-tool-installer').setup({
            ensure_installed = packages,
        })
    end,
}
