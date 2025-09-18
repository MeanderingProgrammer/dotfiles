---@module 'conform'
---@module 'dap'
---@module 'lint'

---@class mp.lang.Config
---@field parser? table<string, mp.parser.Config>
---@field tool? table<string, mp.tool.Config>
---@field lsp? table<string, mp.lsp.Config>
---@field dap? mp.dap.Config
---@field format? table<string, mp.format.Config>
---@field lint? table<string, mp.lint.Config>

---@class mp.parser.Config: mp.install.Config

---@class mp.tool.Config: mp.install.Config

---@class mp.install.Config
---@field install boolean

---@class mp.lsp.Config: vim.lsp.Config

---@class mp.dap.Config
---@field adapters table<string, dap.ExecutableAdapter>
---@field configurations table<string, dap.Configuration[]>

---@class mp.format.Config: mp.filetype.Config
---@field init? fun()
---@field override? conform.FormatterConfigOverride

---@class mp.lint.Config: mp.filetype.Config
---@field condition? fun(): boolean
---@field override? fun(linter: lint.Linter)

---@class mp.filetype.Config
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
    M.config = vim.tbl_deep_extend('error', M.config, config)
end

---@return string[]
function M.parsers()
    return M.install(M.config.parser)
end

---@return string[]
function M.tools()
    return M.install(M.config.tool)
end

---@return table<string, mp.lsp.Config>
function M.lsp()
    return M.config.lsp
end

---@return mp.dap.Config
function M.dap()
    return M.config.dap
end

---@return table<string, mp.format.Config>
function M.formatters()
    return M.config.format
end

---@return table<string, mp.lint.Config>
function M.linters()
    return M.config.lint
end

---@private
---@param configs table<string, mp.install.Config>
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

---@param configs table<string, mp.filetype.Config>
---@return string[], table<string, string[]>
function M.by_ft(configs)
    local names = {} ---@type string[]
    local result = {} ---@type table<string, string[]>
    for name, config in pairs(configs) do
        local cmd = config.cmd or name
        if vim.fn.executable(cmd) == 1 then
            names[#names + 1] = name
            for _, filetype in ipairs(config.filetypes) do
                if not result[filetype] then
                    result[filetype] = {}
                end
                local active = result[filetype]
                active[#active + 1] = name
                table.sort(active)
            end
        end
    end
    return names, result
end

return M
