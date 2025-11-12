---@module 'conform'
---@module 'dap'
---@module 'lint'

---@class mp.lang.Opts: mp.lang.Config
---@field disabled? true

---@class mp.lang.Config
---@field parser? table<string, mp.parser.Config>
---@field tool? table<string, mp.tool.Config>
---@field lsp? table<string, mp.lsp.Config>
---@field dap? mp.dap.Config
---@field format? table<string, mp.format.Config>
---@field lint? table<string, mp.lint.Config>

---@class mp.parser.Config: mp.install.Config
---@field filetypes? string[]

---@class mp.tool.Config: mp.install.Config
---@field version? string

---@class mp.install.Config
---@field install boolean

---@class mp.lsp.Config
---@field cmd? string

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

---@param opts mp.lang.Opts
function M.add(opts)
    if not opts.disabled then
        M.config = vim.tbl_deep_extend('error', M.config, opts)
    end
end

---@return table<string, mp.parser.Config>
function M.parsers()
    return M.install(M.config.parser)
end

---@return table<string, mp.tool.Config>
function M.tools()
    return M.install(M.config.tool)
end

---@private
---@generic T: mp.install.Config
---@param configs table<string, T>
---@return table<string, T>
function M.install(configs)
    local result = {} ---@type table<string, mp.install.Config>
    ---@cast configs table<string, mp.install.Config>
    for name, config in pairs(configs) do
        if config.install then
            result[name] = config
        end
    end
    return result
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
    return M.executable(M.config.format)
end

---@return table<string, mp.lint.Config>
function M.linters()
    return M.executable(M.config.lint)
end

---@private
---@generic T: mp.filetype.Config
---@param configs table<string, T>
---@return table<string, T>
function M.executable(configs)
    local result = {} ---@type table<string, mp.filetype.Config>
    ---@cast configs table<string, mp.filetype.Config>
    for name, config in pairs(configs) do
        local cmd = config.cmd or name
        if vim.fn.executable(cmd) == 1 then
            result[name] = config
        end
    end
    return result
end

---@param configs table<string, mp.filetype.Config>
---@return table<string, string[]>
function M.by_ft(configs)
    local result = {} ---@type table<string, string[]>
    for name, config in pairs(configs) do
        for _, filetype in ipairs(config.filetypes) do
            if not result[filetype] then
                result[filetype] = {}
            end
            local active = result[filetype]
            active[#active + 1] = name
            table.sort(active)
        end
    end
    return result
end

return M
