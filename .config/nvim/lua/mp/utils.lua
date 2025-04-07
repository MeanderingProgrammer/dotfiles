---@class lua.mp.Utils
local M = {}

---@param override? lsp.ClientCapabilities
---@return lsp.ClientCapabilities
function M.capabilities(override)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local has_cmp, cmp = pcall(require, 'cmp_nvim_lsp')
    if has_cmp then
        capabilities = M.extend(capabilities, cmp.default_capabilities())
    end
    local has_blink, blink = pcall(require, 'blink.cmp')
    if has_blink then
        capabilities = M.extend(capabilities, blink.get_lsp_capabilities())
    end
    return M.extend(capabilities, override or {})
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
    return vim.fn.stdpath('config') .. '/lint_configs/' .. file
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
