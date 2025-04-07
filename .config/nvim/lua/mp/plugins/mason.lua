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
    },
    config = function(_, opts)
        require('mason').setup({})

        require('mason-tool-installer').setup({
            ensure_installed = opts.install,
        })

        ---@param bufnr integer
        ---@return boolean
        local skip_format = function(bufnr)
            local filetype = vim.bo[bufnr].filetype
            if vim.tbl_contains({ 'json' }, filetype) then
                return true
            end
            local path = vim.api.nvim_buf_get_name(bufnr)
            for _, folder in ipairs({ 'open-source' }) do
                folder = string.format('/%s/', folder)
                if path:find(folder, 1, true) ~= nil then
                    return true
                end
            end
            return false
        end

        local conform = require('conform')
        conform.setup({
            formatters_by_ft = opts.formatters,
            format_after_save = function(bufnr)
                if skip_format(bufnr) then
                    return nil
                else
                    return { lsp_format = 'fallback' }
                end
            end,
        })
        for name, override in pairs(opts.formatter_overrides) do
            conform.formatters[name] = override
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
                lint.try_lint()
            end,
        })
    end,
}
