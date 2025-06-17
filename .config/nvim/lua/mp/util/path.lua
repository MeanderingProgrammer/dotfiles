---@class mp.util.Path
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

---@param file string
---@return string
function M.lint(file)
    return vim.fs.joinpath(vim.fn.stdpath('config'), 'lint_configs', file)
end

---@param files string[]
---@return boolean
function M.in_root(files)
    local result = false
    local cwd = assert(vim.uv.cwd())
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

return M
