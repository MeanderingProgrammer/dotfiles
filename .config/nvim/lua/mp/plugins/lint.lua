---@alias mp.lint.Config table<string, mp.lint.Tool>

---@class mp.lint.Tool: mp.filetype.Tool
---@field override? fun(linter: lint.Linter)
---@field condition? fun(): boolean

return {
    'mfussenegger/nvim-lint',
    dependencies = { 'mason-org/mason.nvim' },
    ---@type mp.lint.Config
    opts = {},
    ---@param opts mp.lint.Config
    config = function(_, opts)
        local lint = require('lint')

        local by_ft = require('mp.util').tool.by_ft(opts)

        local run_lint = function()
            local result = {} ---@type string[]
            local linters = by_ft[vim.bo.filetype] or {}
            for _, linter in ipairs(linters) do
                local condition = opts[linter].condition
                if not condition or condition() then
                    result[#result + 1] = linter
                end
            end
            if #result > 0 then
                lint.try_lint(result)
            end
        end

        lint.linters_by_ft = by_ft
        for name, tool in pairs(opts) do
            if tool.override then
                local linter = lint.linters[name]
                assert(type(linter) ~= 'function')
                tool.override(linter)
            end
        end

        local lint_events = { 'BufRead', 'BufWritePost', 'InsertLeave' }
        vim.api.nvim_create_autocmd(lint_events, {
            group = vim.api.nvim_create_augroup('user.lint', {}),
            callback = run_lint,
        })

        vim.api.nvim_create_user_command('Lint', run_lint, {})
    end,
}
