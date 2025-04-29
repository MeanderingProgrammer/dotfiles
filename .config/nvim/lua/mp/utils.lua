---@class lua.mp.Utils
local M = {}

---@param override? lsp.ClientCapabilities
---@return lsp.ClientCapabilities
function M.capabilities(override)
    local result = vim.lsp.protocol.make_client_capabilities()
    local has_cmp, cmp = pcall(require, 'cmp_nvim_lsp')
    if has_cmp then
        result = M.extend(result, cmp.default_capabilities())
    end
    local has_blink, blink = pcall(require, 'blink.cmp')
    if has_blink then
        result = M.extend(result, blink.get_lsp_capabilities())
    end
    return M.extend(result, override or {})
end

---@private
---@param base lsp.ClientCapabilities
---@param override lsp.ClientCapabilities
---@return lsp.ClientCapabilities
function M.extend(base, override)
    return vim.tbl_deep_extend('force', base, override)
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
        result = result or (M.exists(path))
    end
    return result
end

---@param path string
---@return boolean
function M.exists(path)
    return vim.uv.fs_stat(vim.fs.abspath(path)) ~= nil
end

---@return string[]
function M.hidden_directories()
    return {
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
end

return M
