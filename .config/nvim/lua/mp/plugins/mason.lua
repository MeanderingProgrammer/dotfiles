return {
    'williamboman/mason.nvim',
    dependencies = {
        'mfussenegger/nvim-lint',
        'stevearc/conform.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    opts = {
        install = {},
        formatters = {},
        formatter_overrides = {},
        linters = {},
        linter_overrides = {},
        linter_conditions = {},
    },
    config = function(_, opts)
        require('mason').setup({})

        require('mason-tool-installer').setup({
            ensure_installed = opts.install,
        })

        ---@param buf integer
        ---@return boolean
        local should_format = function(buf)
            local filetype = vim.bo[buf].filetype
            if vim.tbl_contains({ 'json' }, filetype) then
                return false
            end
            local path = vim.api.nvim_buf_get_name(buf)
            -- outside of repos we should always format
            -- inside of repos only format personal repos
            local repo = vim.fs.relpath('~/dev/repos', path)
            return not repo or vim.startswith(repo, 'personal')
        end

        local conform = require('conform')
        conform.setup({
            formatters_by_ft = opts.formatters,
            format_after_save = function(buf)
                if should_format(buf) then
                    return { lsp_format = 'fallback' }
                else
                    return nil
                end
            end,
        })
        for name, override in pairs(opts.formatter_overrides) do
            conform.formatters[name] = override
        end

        ---@return string[]
        local get_linters = function()
            local filetype = vim.bo.filetype
            local linters = opts.linters[filetype] or {}
            local result = {}
            for _, linter in ipairs(linters) do
                local condition = opts.linter_conditions[linter]
                if not condition or condition() then
                    result[#result + 1] = linter
                end
            end
            return result
        end

        local lint = require('lint')
        lint.linters_by_ft = opts.linters
        for name, override in pairs(opts.linter_overrides) do
            lint.linters[name] = override(lint.linters[name])
        end

        local lint_events = { 'BufRead', 'BufWritePost', 'InsertLeave' }
        vim.api.nvim_create_autocmd(lint_events, {
            group = vim.api.nvim_create_augroup('NvimLint', {}),
            callback = function()
                local linters = get_linters()
                if #linters > 0 then
                    lint.try_lint(linters)
                end
            end,
        })
    end,
}
