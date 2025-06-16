---@class mp.Util
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

---@generic T
---@param default? T
---@param phone? T
---@return T?
function M.pc(default, phone)
    return vim.g.pc and default or phone
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

---@param buf integer
---@return string[]
function M.lsp_names(buf)
    local result = {} ---@type string[]
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
        result[#result + 1] = client.name
    end
    return result
end

---@return lsp.ClientCapabilities
function M.capabilities()
    local result = {}
    local has_cmp, cmp = pcall(require, 'cmp_nvim_lsp')
    if has_cmp then
        local capabilities = cmp.default_capabilities()
        result = vim.tbl_deep_extend('force', result, capabilities)
    end
    local has_blink, blink = pcall(require, 'blink.cmp')
    if has_blink then
        local capabilities = blink.get_lsp_capabilities()
        result = vim.tbl_deep_extend('force', result, capabilities)
    end
    return result
end

return M
