local Float = require('mp.float')
local utils = require('mp.utils')

---@class mp.brew.Formula
---@field name string
---@field dependencies string[]
---@field versions mp.brew.Versions
---@field installed mp.brew.Installed[]
---@field outdated boolean

---@class mp.brew.Versions
---@field stable string

---@class mp.brew.Installed
---@field version string

---@param list string[]
---@param size integer
---@return string[][]
local function chunk(list, size)
    local result = {} ---@type string[][]
    for i = 1, #list, size do
        local group = {} ---@type string[]
        for j = i, math.min(i + size - 1, #list) do
            group[#group + 1] = list[j]
        end
        result[#result + 1] = group
    end
    return result
end

---@param installed mp.brew.Installed[]
---@return string?
local function get_current(installed)
    local versions = {} ---@type string[]
    for _, value in ipairs(installed) do
        local version = value.version
        if not vim.list_contains(versions, version) then
            versions[#versions + 1] = version
        end
    end
    return #versions == 1 and versions[1] or nil
end

vim.api.nvim_create_user_command('Brew', function()
    utils.execute({ 'brew', 'update' })

    local out = utils.execute({ 'brew', 'info', '--installed', '--json=v2' })
    local formulas = vim.fn.json_decode(out).formulae ---@type mp.brew.Formula[]

    local lines = {} ---@type string[]
    lines[#lines + 1] = '# Info'
    lines[#lines + 1] = ''
    lines[#lines + 1] = '| name | version | upgrade | dependencies |'
    lines[#lines + 1] = '| ---- | ------- | ------- | ------------ |'
    for _, formula in ipairs(formulas) do
        local name = formula.name
        local chunks = chunk(formula.dependencies, 5)
        local latest = formula.versions.stable

        local current = get_current(formula.installed)
        if not current then
            error(('%s: invalid installed'):format(name))
        end

        -- current = 0.25.0_1, latest = 0.25.0 -> false
        local upgrade = not vim.startswith(current, latest)
        if upgrade ~= formula.outdated then
            error(('%s: invalid outdated'):format(name))
        end

        ---@type string[]
        local parts = {
            name,
            current,
            upgrade and latest or 'none',
            #chunks == 0 and 'none' or table.concat(chunks[1], ', '),
        }
        lines[#lines + 1] = '| ' .. table.concat(parts, ' | ') .. ' |'
        for i = 2, #chunks do
            local part = table.concat(chunks[i], ', ')
            lines[#lines + 1] = ('| | | | %s |'):format(part)
        end
    end

    Float.new('Homebrew', 'markdown'):lines(lines)
end, {})
