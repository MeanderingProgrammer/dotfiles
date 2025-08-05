---@class mp.Utils
local M = {}

---@type string[]
M.hidden = {
    '__pycache__',
    '_build',
    '.git',
    '.gradle',
    '.idea',
    '.mypy_cache',
    '.obsidian',
    '.pytest_cache',
    '.settings',
    '.zig-cache',
    'node_modules',
    'target',
    'zig-out',
}

---@param s string
---@param sep string
---@param trimempty? boolean
---@return string[]
function M.split(s, sep, trimempty)
    return vim.split(s, sep, { plain = true, trimempty = trimempty })
end

---@param file string
---@return string
function M.lint_config(file)
    return vim.fs.joinpath(vim.fn.stdpath('config'), 'lint_configs', file)
end

---@param files string[]
---@return boolean
function M.in_root(files)
    local result = false
    local cwd = vim.fn.getcwd()
    for _, file in ipairs(files) do
        local path = vim.fs.joinpath(cwd, file)
        result = result or M.exists(path)
    end
    return result
end

---@param path string
---@return boolean
function M.exists(path)
    return vim.uv.fs_stat(vim.fs.abspath(path)) ~= nil
end

---@param buf integer
---@return string[]
function M.lsp_names(buf)
    local result = {} ---@type string[]
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
        result[#result + 1] = client.name
    end
    return result
end

---@param method string
---@param params table
---@return vim.lsp.Client?, any
function M.lsp_request(method, params)
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
