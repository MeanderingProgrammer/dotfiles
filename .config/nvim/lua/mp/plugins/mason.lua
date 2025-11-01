local lang = require('mp.lib.lang')

---@class mp.mason.Package
---@field [1] string
---@field version? string

return {
    'mason-org/mason.nvim',
    dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    config = function()
        local configs = lang.tools()
        local names = lang.install(configs)
        local packages = {} ---@type mp.mason.Package[]
        for _, name in ipairs(names) do
            packages[#packages + 1] = { name, version = configs[name].version }
        end

        require('mason').setup({})
        require('mason-tool-installer').setup({
            ensure_installed = packages,
        })
    end,
}
