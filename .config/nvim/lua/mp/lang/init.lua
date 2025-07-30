---@module 'conform'
---@module 'dap'
---@module 'lint'

---@class mp.lang.Config
---@field parser? table<string, mp.lang.parser.Config>
---@field tool? table<string, mp.lang.tool.Config>
---@field lsp? table<string, mp.lang.lsp.Config>
---@field dap? mp.lang.dap.Config
---@field format? table<string, mp.lang.format.Config>
---@field lint? table<string, mp.lang.lint.Config>

---@class mp.lang.parser.Config: mp.lang.install.Config

---@class mp.lang.tool.Config: mp.lang.install.Config

---@class mp.lang.lsp.Config: vim.lsp.Config

---@class mp.lang.dap.Config
---@field adapters table<string, dap.ExecutableAdapter>
---@field configurations table<string, dap.Configuration[]>

---@class mp.lang.format.Config: mp.lang.filetype.Config
---@field init? fun()
---@field override? conform.FormatterConfigOverride

---@class mp.lang.lint.Config: mp.lang.filetype.Config
---@field condition? fun(): boolean
---@field override? fun(linter: lint.Linter)

---@class mp.lang.install.Config
---@field install boolean

---@class mp.lang.filetype.Config
---@field cmd? string
---@field filetypes string[]

---@class mp.Lang
local M = {}

---@private
---@type mp.lang.Config
M.config = {
    parser = {},
    tool = {},
    lsp = {},
    dap = {
        adapters = {},
        configurations = {},
    },
    format = {},
    lint = {},
}

---@param config mp.lang.Config
function M.add(config)
    M.config = vim.tbl_deep_extend('force', M.config, config)
end

---@return string[]
function M.parsers()
    return M.install(M.config.parser)
end

---@return string[]
function M.tools()
    return M.install(M.config.tool)
end

---@return table<string, mp.lang.lsp.Config>
function M.lsp()
    return M.config.lsp
end

---@return mp.lang.dap.Config
function M.dap()
    return M.config.dap
end

---@return table<string, mp.lang.format.Config>
function M.formatters()
    return M.config.format
end

---@return table<string, mp.lang.lint.Config>
function M.linters()
    return M.config.lint
end

---@private
---@param configs table<string, mp.lang.install.Config>
---@return string[]
function M.install(configs)
    local result = {} ---@type string[]
    for name, config in pairs(configs) do
        if config.install then
            result[#result + 1] = name
        end
    end
    return result
end

---@param configs table<string, mp.lang.filetype.Config>
---@return table<string, string[]>
function M.by_ft(configs)
    local result = {} ---@type table<string, string[]>
    for name, config in pairs(configs) do
        local cmd = config.cmd or name
        if vim.fn.executable(cmd) == 1 then
            for _, filetype in ipairs(config.filetypes) do
                local active = result[filetype] or {}
                if #active == 0 then
                    result[filetype] = active
                end
                active[#active + 1] = name
                table.sort(active)
            end
        end
    end
    return result
end

return M
