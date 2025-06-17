---@alias mp.mason.Config table<string, mp.mason.Tool>

---@class mp.mason.Tool
---@field install boolean

return {
    'mason-org/mason.nvim',
    dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    ---@type mp.mason.Config
    opts = {},
    ---@param opts mp.mason.Config
    config = function(_, opts)
        require('mason').setup({})

        local install = {} ---@type string[]
        for name, tool in pairs(opts) do
            if tool.install then
                install[#install + 1] = name
            end
        end

        require('mason-tool-installer').setup({
            ensure_installed = install,
        })
    end,
}
