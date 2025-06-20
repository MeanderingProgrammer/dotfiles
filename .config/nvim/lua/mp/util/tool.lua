---@class mp.install.Tool
---@field install boolean

---@class mp.filetype.Tool
---@field cmd? string
---@field filetypes string[]

---@class mp.util.Tool
local M = {}

---@param tools table<string, mp.install.Tool>
---@return string[]
function M.install(tools)
    local result = {} ---@type string[]
    for name, tool in pairs(tools) do
        if tool.install then
            result[#result + 1] = name
        end
    end
    return result
end

---@param tools table<string, mp.filetype.Tool>
---@return table<string, string[]>
function M.by_ft(tools)
    local result = {} ---@type table<string, string[]>
    for name, tool in pairs(tools) do
        local cmd = tool.cmd or name
        if vim.fn.executable(cmd) == 1 then
            for _, filetype in ipairs(tool.filetypes) do
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
