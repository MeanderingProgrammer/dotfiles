local langs = require('mp.lib.langs')

---@class mp.mason.Package
---@field [1] string
---@field version? string

local configs = langs.tools()
local packages = {} ---@type mp.mason.Package[]
for name, config in pairs(configs) do
    packages[#packages + 1] = { name, version = config.version }
end

require('mason').setup({})
require('mason-tool-installer').setup({
    ensure_installed = packages,
})
