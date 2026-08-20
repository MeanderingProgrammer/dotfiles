local utils = require('mp.lib.utils')

---@type vim.lsp.Config
return {
    settings = {},
    before_init = function(_, config)
        local library = {} ---@type string[]
        local files = vim.api.nvim_get_runtime_file('', true)
        for _, file in ipairs(files) do
            if utils.exists(vim.fs.joinpath(file, 'lua')) then
                library[#library + 1] = file
            end
        end
        config.settings.Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = { library = library },
        }
    end,
}
