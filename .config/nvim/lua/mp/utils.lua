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

---@param cmd string
---@return string
function M.exec(cmd)
    return vim.api.nvim_exec2(cmd, { output = true }).output
end

---@param cmd string[]
---@param opts? vim.SystemOpts
---@return string
function M.execute(cmd, opts)
    opts = vim.tbl_deep_extend('error', opts or {}, { text = true })
    local result = vim.system(cmd, opts):wait()
    assert(result.code == 0, result.stderr)
    return assert(result.stdout, 'missing stdout')
end

---@param file string
---@return string
function M.lint_config(file)
    return vim.fs.joinpath(vim.fn.stdpath('config'), 'lint_configs', file)
end

---@param ... string
---@return boolean
function M.in_root(...)
    local root = vim.fn.getcwd()
    for _, file in ipairs({ ... }) do
        local path = vim.fs.joinpath(root, file)
        if M.exists(path) then
            return true
        end
    end
    return false
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

return M
