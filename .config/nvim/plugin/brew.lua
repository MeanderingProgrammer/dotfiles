local Float = require('mp.lib.float')
local utils = require('mp.lib.utils')

---@class mp.brew.Formula
---@field name string
---@field dependencies string[]
---@field versions mp.brew.Versions
---@field revision integer
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

vim.api.nvim_create_user_command('Brew', function()
    utils.system({ 'brew', 'update' })

    local out = utils.system({ 'brew', 'info', '--installed', '--json=v2' })
    local formulas = vim.fn.json_decode(out).formulae ---@type mp.brew.Formula[]

    local lines = {} ---@type string[]
    lines[#lines + 1] = '# Info'
    lines[#lines + 1] = ''
    lines[#lines + 1] = '| name | version | upgrade | dependencies |'
    lines[#lines + 1] = '| ---- | ------- | ------- | ------------ |'
    for _, formula in ipairs(formulas) do
        local name = formula.name
        local dependencies = formula.dependencies
        local versions = formula.versions
        local revision = formula.revision
        local installed = formula.installed
        local outdated = formula.outdated

        local chunks = chunk(dependencies, 5)

        local latest = versions.stable
        if revision > 0 then
            latest = ('%s_%d'):format(latest, revision)
        end

        local values = {} ---@type string[]
        for _, value in ipairs(installed) do
            local version = value.version
            if not vim.list_contains(values, version) then
                values[#values + 1] = version
            end
        end
        local current = #values == 1 and values[1] or nil
        if not current then
            error(('%s: invalid installed'):format(name))
        end

        local upgrade = (current ~= latest) or outdated

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
