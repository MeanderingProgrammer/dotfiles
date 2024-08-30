---@class lua.mp.Utils
local M = {}

---@type boolean
M.is_android = vim.uv.os_uname().release:find('android') ~= nil

---@param file string
---@return string
function M.lint_config(file)
    return vim.fn.stdpath('config') .. '/lint_configs/' .. file
end

---@generic T
---@param values table<string, T>
---@return { mason: table<string, T>, system: table<string, T> }
function M.filter_packages(values)
    local mason, system = {}, {}
    for name, value in pairs(values) do
        if not M.is_android then
            mason[name] = value
        elseif vim.tbl_contains({ 'bashls', 'go', 'gopls', 'markdown', 'pyright', 'python' }, name) then
            mason[name] = value
        elseif vim.tbl_contains({ 'lua', 'lua_ls', 'rust_analyzer' }, name) then
            system[name] = value
        end
    end
    return { mason = mason, system = system }
end

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

---@return string[]
function M.hidden_directories()
    local directories = { '.git', '.idea', '.obsidian' }
    vim.list_extend(directories, { '.gradle', '_build', 'target', 'node_modules' })
    vim.list_extend(directories, { '__pycache__', '.pytest_cache', '.mypy_cache' })
    return directories
end

return M
