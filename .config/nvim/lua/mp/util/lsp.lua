---@class mp.util.Lsp
local M = {}

---@param buf integer
---@return string[]
function M.names(buf)
    local result = {} ---@type string[]
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
        result[#result + 1] = client.name
    end
    return result
end

return M
