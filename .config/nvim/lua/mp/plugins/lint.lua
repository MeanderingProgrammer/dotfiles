return {
    'mfussenegger/nvim-lint',
    dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    opts = {
        linters_by_ft = {},
        linter_override = {},
        events = { 'BufRead', 'BufWritePost', 'InsertLeave' },
    },
    config = function(_, opts)
        local utils = require('mp.utils')
        require('mason-tool-installer').setup({
            ensure_installed = utils.flat_values(opts.linters_by_ft),
        })

        local lint = require('lint')
        lint.linters_by_ft = opts.linters_by_ft
        for name, override in pairs(opts.linter_override) do
            lint.linters[name] = override(lint.linters[name])
        end
        vim.api.nvim_create_autocmd(opts.events, {
            group = vim.api.nvim_create_augroup('NvimLint', { clear = true }),
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
