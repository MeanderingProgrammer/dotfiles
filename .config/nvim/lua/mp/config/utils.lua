local M = {}

---@param config table<string, string[]>
---@return string[]
function M.flat_values(config)
    local result = {}
    for _, values in pairs(config) do
        for _, value in ipairs(values) do
            if not vim.tbl_contains(result, value) then
                table.insert(result, value)
            end
        end
    end
    return result
end

---@param f fun(opts: any)
---@param opts any
---@return fun()
function M.thunk(f, opts)
    return function()
        f(opts)
    end
end

return M
