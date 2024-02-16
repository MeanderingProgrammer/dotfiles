local M = {}

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

---@param lhs string|integer
---@param f fun(opts: any)|string
---@param desc string
---@param opts any
function M.leader_map(lhs, f, desc, opts)
    M.map('<leader>' .. lhs, f, desc, nil, opts)
end

---@param lhs string
---@param f fun(opts: any)|string
---@param desc string
---@param buf integer|nil
---@param opts any
function M.map(lhs, f, desc, buf, opts)
    ---@return fun()|string
    local function rhs()
        if type(f) == 'string' then
            return '<cmd>' .. f .. '<cr>'
        else
            return function()
                f(opts)
            end
        end
    end
    local keymap_opts = { silent = true, desc = desc }
    if buf ~= nil then
        keymap_opts.buffer = buf
    end
    vim.keymap.set('n', lhs, rhs(), keymap_opts)
end

return M
