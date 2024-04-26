return {
    'stevearc/conform.nvim',
    dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    opts = {
        formatters_by_ft = {},
        format_after_save = {
            lsp_fallback = true,
        },
    },
    config = function(_, opts)
        local utils = require('mp.utils')
        require('mason-tool-installer').setup({
            ensure_installed = utils.flat_values(opts.formatters_by_ft),
        })

        -- Due to prettierd not picking up changes
        vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
            group = vim.api.nvim_create_augroup('RestartPrettierd', { clear = true }),
            pattern = '*prettier*',
            callback = function()
                vim.fn.system('prettierd restart')
            end,
        })

        require('conform').setup(opts)
    end,
}
