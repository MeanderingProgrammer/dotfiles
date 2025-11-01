local lang = require('mp.lib.lang')

return {
    'mfussenegger/nvim-lint',
    dependencies = { 'mason-org/mason.nvim' },
    config = function()
        local configs = lang.linters()
        local names = lang.executable(configs)
        local by_ft = lang.by_ft(names, configs)

        local lint = require('lint')

        local seen = {} ---@type string[]
        local function run_lint()
            local result = {} ---@type string[]
            local linters = by_ft[vim.bo.filetype] or {}
            for _, name in ipairs(linters) do
                local config = configs[name]
                if not vim.list_contains(seen, name) then
                    seen[#seen + 1] = name
                    if config.override then
                        local linter = lint.linters[name]
                        assert(type(linter) == 'table', 'invalid linter')
                        config.override(linter)
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

        local event = { 'BufRead', 'BufWritePost', 'InsertLeave' }
        vim.api.nvim_create_autocmd(event, {
            group = vim.api.nvim_create_augroup('mp.lint', {}),
            callback = run_lint,
        })

        vim.api.nvim_create_user_command('Lint', run_lint, {})
    end,
}
