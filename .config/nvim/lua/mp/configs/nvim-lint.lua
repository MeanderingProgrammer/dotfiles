local langs = require('mp.lib.langs')
local lint = require('lint')
local utils = require('mp.lib.utils')

local configs = langs.linters()
local by_ft = langs.by_ft(configs)

local seen = {} ---@type string[]

---@param force boolean
local function run_lint(force)
    if not force and not utils.personal() then
        return
    end
    local result = {} ---@type string[]
    local linters = by_ft[vim.bo.filetype] or {}
    for _, name in ipairs(linters) do
        local config = configs[name]
        if not vim.list_contains(seen, name) then
            seen[#seen + 1] = name
            local args = config.args
            if args then
                local linter = lint.linters[name]
                assert(type(linter) == 'table', 'invalid linter')
                linter.args = vim.list_extend(linter.args, args())
            end
        end
        local condition = config.condition
        if not condition or condition() then
            result[#result + 1] = name
        end
    end
    if #result > 0 then
        lint.try_lint(result)
    end
end

vim.api.nvim_create_autocmd({ 'BufRead', 'BufWritePost', 'InsertLeave' }, {
    group = utils.augroup('lint'),
    callback = function()
        run_lint(false)
    end,
})

vim.api.nvim_create_user_command('Lint', function()
    run_lint(true)
end, {})
