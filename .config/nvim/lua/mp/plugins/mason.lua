return {
    'mason-org/mason.nvim',
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
    opts_extend = { 'install' },
    config = function(_, opts)
        require('mason').setup({})

        require('mason-tool-installer').setup({
            ensure_installed = opts.install,
        })

        local conform = require('conform')

        ---@param buf integer
        ---@return conform.LspFormatOpts
        local lsp_format = function(buf)
            local clients = require('mp.util').lsp_names(buf)
            if vim.tbl_contains(clients, 'jsonls') then
                return 'never'
            end
            -- outside of repos we should always format
            -- inside of repos only format personal repos
            local path = vim.api.nvim_buf_get_name(buf)
            local repo = vim.fs.relpath('~/dev/repos', path)
            local format = not repo or vim.startswith(repo, 'personal')
            return format and 'fallback' or 'never'
        end

        conform.setup({
            formatters_by_ft = opts.formatters,
            format_after_save = function(buf)
                return { lsp_format = lsp_format(buf) }
            end,
        })
        for name, override in pairs(opts.formatter_overrides) do
            conform.formatters[name] = override
        end

        local lint = require('lint')

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

        lint.linters_by_ft = opts.linters
        for name, override in pairs(opts.linter_overrides) do
            lint.linters[name] = override(lint.linters[name])
        end

        local lint_events = { 'BufRead', 'BufWritePost', 'InsertLeave' }
        vim.api.nvim_create_autocmd(lint_events, {
            group = vim.api.nvim_create_augroup('user.lint', {}),
            callback = function()
                local linters = get_linters()
                if #linters > 0 then
                    lint.try_lint(linters)
                end
            end,
        })
    end,
}
