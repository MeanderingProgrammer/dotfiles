---@class lua.mp.Utils
local M = {}

---@type boolean
M.is_mac = vim.fn.has('mac') == 1

---@type boolean
M.is_android = vim.uv.os_uname().release:find('android') ~= nil

---@param override? lsp.ClientCapabilities
---@return lsp.ClientCapabilities
function M.capabilities(override)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local has_cmp, cmp = pcall(require, 'cmp_nvim_lsp')
    if has_cmp then
        capabilities = vim.tbl_deep_extend('force', capabilities, cmp.default_capabilities())
    end
    local has_blink, blink = pcall(require, 'blink.cmp')
    if has_blink then
        capabilities = vim.tbl_deep_extend('force', capabilities, blink.get_lsp_capabilities())
    end
    return vim.tbl_deep_extend('force', capabilities, override or {})
end

---@param file string
---@return string
function M.lint_config(file)
    return vim.fn.stdpath('config') .. '/lint_configs/' .. file
end

---@return string[]
function M.hidden_directories()
    local result = { '.git', '.idea', '.obsidian' }
    vim.list_extend(result, { '.gradle', '.settings', '_build', 'target' })
    vim.list_extend(result, { 'node_modules', 'zig-out', '.zig-cache' })
    vim.list_extend(result, { '__pycache__', '.pytest_cache', '.mypy_cache' })
    return result
end

return M
