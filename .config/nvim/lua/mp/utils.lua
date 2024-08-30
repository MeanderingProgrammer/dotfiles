---@class lua.mp.Utils
local M = {}

---@type boolean
M.is_mac = vim.fn.has('mac') == 1

---@type boolean
M.is_android = vim.uv.os_uname().release:find('android') ~= nil

---@param file string
---@return string
function M.lint_config(file)
    return vim.fn.stdpath('config') .. '/lint_configs/' .. file
end

---@return string[]
function M.hidden_directories()
    local directories = { '.git', '.idea', '.obsidian' }
    vim.list_extend(directories, { '.gradle', '_build', 'target', 'node_modules' })
    vim.list_extend(directories, { '__pycache__', '.pytest_cache', '.mypy_cache' })
    return directories
end

return M
