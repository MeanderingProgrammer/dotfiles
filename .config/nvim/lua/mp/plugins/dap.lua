---@class mp.dap.Config
---@field adapters table<string, mp.dap.Adapter>
---@field configurations table<string, dap.Configuration[]>

---@alias mp.dap.Adapter dap.ExecutableAdapter

return {
    'mfussenegger/nvim-dap',
    dependencies = { 'mason-org/mason.nvim' },
    ---@type mp.dap.Config
    opts = {
        adapters = {},
        configurations = {},
    },
    ---@param opts mp.dap.Config
    config = function(_, opts)
        local dap = require('dap')

        for name, adapter in pairs(opts.adapters) do
            assert(adapter.type == 'executable')
            if vim.fn.executable(adapter.command) == 1 then
                dap.adapters[name] = adapter
            end
        end

        for language, configs in pairs(opts.configurations) do
            local active = {} ---@type dap.Configuration[]
            for _, config in ipairs(configs) do
                if dap.adapters[config.type] then
                    active[#active + 1] = config
                end
            end
            if #active > 0 then
                dap.configurations[language] = active
            end
        end
    end,
}
