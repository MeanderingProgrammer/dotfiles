local utils = require('mp.utils')

return {
    'mfussenegger/nvim-lint',
    dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    opts = {
        linters_by_ft = {},
        linter_override = {},
    },
    config = function(_, opts)
        local filtered = utils.filter_packages(opts.linters_by_ft)
        local mason_linters, system_linters = filtered.mason, filtered.system
        require('mason-tool-installer').setup({
            ensure_installed = utils.flat_values(mason_linters),
        })
        local linters = vim.tbl_deep_extend('force', mason_linters, system_linters)

        local lint = require('lint')
        lint.linters_by_ft = linters
        for name, override in pairs(opts.linter_override) do
            if vim.tbl_contains(utils.flat_values(linters), name) then
                lint.linters[name] = override(lint.linters[name])
            end
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
