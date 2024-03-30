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

        require('conform').setup(opts)
    end,
}
