---@class mp.Tool
---@field filetypes string[]

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

---@param tools table<string, mp.Tool>
---@return table<string, string[]>
function M.by_ft(tools)
    local result = {} ---@type table<string, string[]>
    for name, tool in pairs(tools) do
        if vim.fn.executable(name) == 1 then
            for _, filetype in ipairs(tool.filetypes) do
                local active = result[filetype] or {}
                if #active == 0 then
                    result[filetype] = active
                end
                active[#active + 1] = name
                table.sort(active)
            end
        end
    end
    return result
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

---@return lsp.ClientCapabilities?
function M.capabilities()
    local ok, cmp = pcall(require, 'cmp_nvim_lsp')
    if ok and cmp then
        return cmp.default_capabilities()
    else
        return nil
    end
end

return M
