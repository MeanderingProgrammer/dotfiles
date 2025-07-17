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

---@param method string
---@param params table
---@return vim.lsp.Client?, any
function M.request(method, params)
    local clients = vim.lsp.get_clients({ bufnr = 0, method = method })
    if #clients ~= 1 then
        vim.print(('%s : %d clients'):format(method, #clients))
        return nil, nil
    end
    local client = clients[1]
    local response = client:request_sync(method, params)
    if not response then
        vim.print(('%s : failed'):format(method))
        return client, nil
    end
    return client, response.result
end

return M
