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
        linters = {},
        linter_overrides = {},
    },
    config = function(_, opts)
        require('mason').setup({})

        require('mason-tool-installer').setup({
            ensure_installed = opts.install,
        })

        require('conform').setup({
            formatters_by_ft = opts.formatters,
            format_after_save = function(bufnr)
                local ft = vim.bo[bufnr].filetype
                if vim.tbl_contains({ 'json' }, ft) then
                    return nil
                end
                local name = vim.api.nvim_buf_get_name(bufnr)
                local disabled_name = name:find('/open-source/', 1, true)
                if disabled_name ~= nil then
                    return nil
                end
                return { lsp_format = 'fallback' }
            end,
        })

        local lint = require('lint')
        lint.linters_by_ft = opts.linters
        for name, override in pairs(opts.linter_overrides) do
            lint.linters[name] = override(lint.linters[name])
        end

        local events = { 'BufRead', 'BufWritePost', 'InsertLeave' }
        vim.api.nvim_create_autocmd(events, {
            group = vim.api.nvim_create_augroup('NvimLint', { clear = true }),
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
