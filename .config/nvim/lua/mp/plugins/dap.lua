local lang = require('mp.lib.lang')

return {
    'mfussenegger/nvim-dap',
    dependencies = { 'mason-org/mason.nvim' },
    config = function()
        local config = lang.dap()

        local dap = require('dap')

        for name, adapter in pairs(config.adapters) do
            assert(adapter.type == 'executable')
            if vim.fn.executable(adapter.command) == 1 then
                dap.adapters[name] = adapter
            end
        end

        for language, configurations in pairs(config.configurations) do
            local active = {} ---@type dap.Configuration[]
            for _, configuration in ipairs(configurations) do
                if dap.adapters[configuration.type] then
                    active[#active + 1] = configuration
                end
            end
            if #active > 0 then
                dap.configurations[language] = active
            end
        end
    end,
}
