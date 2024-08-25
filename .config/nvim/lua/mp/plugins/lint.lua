return {
    'mfussenegger/nvim-lint',
    enabled = not require('mp.utils').is_termux,
    dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    opts = {
        linters_by_ft = {},
        linter_override = {},
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

        local events = { 'BufRead', 'BufWritePost', 'InsertLeave' }
        vim.api.nvim_create_autocmd(events, {
            group = vim.api.nvim_create_augroup('NvimLint', { clear = true }),
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
