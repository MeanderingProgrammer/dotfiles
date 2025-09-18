local lang = require('mp.lib.lang')

return {
    'mfussenegger/nvim-lint',
    dependencies = { 'mason-org/mason.nvim' },
    config = function()
        local configs = lang.linters()
        local names, by_ft = lang.by_ft(configs)

        local lint = require('lint')

        local function run_lint()
            local result = {} ---@type string[]
            local linters = by_ft[vim.bo.filetype] or {}
            for _, linter in ipairs(linters) do
                local condition = configs[linter].condition
                if not condition or condition() then
                    result[#result + 1] = linter
                end
            end
            if #result > 0 then
                lint.try_lint(result)
            end
        end

        lint.linters_by_ft = by_ft
        for _, name in ipairs(names) do
            local config = configs[name]
            if config.override then
                local linter = lint.linters[name]
                assert(type(linter) == 'table', 'invalid linter')
                config.override(linter)
            end
        end

        local event = { 'BufRead', 'BufWritePost', 'InsertLeave' }
        vim.api.nvim_create_autocmd(event, {
            group = vim.api.nvim_create_augroup('my.lint', {}),
            callback = run_lint,
        })

        vim.api.nvim_create_user_command('Lint', run_lint, {})
    end,
}
