---@class mp.keymap.Opts: vim.keymap.set.Opts
---@field mode? string|string[]
---@field prefix? string
---@field group? string

---@class mp.Keymap
---@field private opts mp.keymap.Opts
local Keymap = {}
Keymap.__index = Keymap

---@param opts mp.keymap.Opts
---@return mp.Keymap
function Keymap.new(opts)
    local self = setmetatable({}, Keymap)
    self.opts = opts
    return self
end

---@param opts mp.keymap.Opts
---@return mp.Keymap
function Keymap:extend(opts)
    return Keymap.new(vim.tbl_deep_extend('force', self.opts, opts))
end

---@param lhs string
---@param rhs string|fun()
---@param desc? string
---@return mp.Keymap
function Keymap:n(lhs, rhs, desc)
    return self:set(lhs, rhs, { mode = 'n', desc = desc })
end

---@param lhs string
---@param rhs string|fun()
---@param desc? string
---@return mp.Keymap
function Keymap:i(lhs, rhs, desc)
    return self:set(lhs, rhs, { mode = 'i', desc = desc })
end

---@param lhs string
---@param rhs string|fun()
---@param desc? string
---@return mp.Keymap
function Keymap:t(lhs, rhs, desc)
    return self:set(lhs, rhs, { mode = 't', desc = desc })
end

---@param lhs string
---@param rhs string|fun()
---@param opts? mp.keymap.Opts
---@return mp.Keymap
function Keymap:set(lhs, rhs, opts)
    opts = vim.tbl_deep_extend('force', self.opts, opts or {})

    local mode = assert(opts.mode, 'missing mode')
    if opts.prefix then
        lhs = opts.prefix .. lhs
    end
    if opts.desc and opts.group then
        opts.desc = opts.group .. ' ' .. opts.desc
    end

    -- start: mp.keymap.Opts
    opts.mode = nil
    opts.prefix = nil
    opts.group = nil
    -- end: vim.keymap.set.Opts

    vim.keymap.set(mode, lhs, rhs, opts)

    return self
end

return Keymap
