local M = {}

---@param file string
---@return string
function M.lint_config(file)
    return vim.fn.stdpath('config') .. '/lint_configs/' .. file
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

---@return boolean
function M.challenge_mode()
    local challenge_directories = { 'leetcode' }
    local directory = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    return vim.tbl_contains(challenge_directories, directory)
end

---@return string[]
function M.hidden_directories()
    local directories = { '.git', '.idea', '.obsidian' }
    vim.list_extend(directories, { '.gradle', '_build', 'target', 'node_modules' })
    vim.list_extend(directories, { '__pycache__', '.pytest_cache', '.mypy_cache' })
    return directories
end

---@param f fun(opts: any)
---@param opts any
---@return fun()
function M.thunk(f, opts)
    return function()
        f(opts)
    end
end

return M
