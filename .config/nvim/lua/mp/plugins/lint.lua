return {
    'mfussenegger/nvim-lint',
    dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    opts = {
        linters_by_ft = {},
        linter_configs = {},
        events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
    },
    config = function(_, opts)
        local ensure_installed = {}
        for _, linters in pairs(opts.linters_by_ft) do
            for _, linter in ipairs(linters) do
                if not vim.tbl_contains(ensure_installed, linter) then
                    table.insert(ensure_installed, linter)
                end
            end
        end
        require('mason-tool-installer').setup({
            ensure_installed = ensure_installed,
        })

        local lint = require('lint')
        lint.linters_by_ft = opts.linters_by_ft
        for name, config in pairs(opts.linter_configs) do
            lint.linters[name] = vim.tbl_deep_extend('force', lint.linters[name], config)
        end
        vim.api.nvim_create_autocmd(opts.events, {
            group = vim.api.nvim_create_augroup('NvimLint', { clear = true }),
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
