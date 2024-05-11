return {
    'stevearc/conform.nvim',
    dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    opts = {
        formatters_by_ft = {},
        disabled_fts = {},
    },
    config = function(_, opts)
        local utils = require('mp.utils')
        require('mason-tool-installer').setup({
            ensure_installed = utils.flat_values(opts.formatters_by_ft),
        })

        require('conform').setup({
            formatters_by_ft = opts.formatters_by_ft,
            format_after_save = function(bufnr)
                local ft = vim.bo[bufnr].filetype
                local disabled = vim.tbl_contains(opts.disabled_fts, ft)
                return { lsp_fallback = not disabled }
            end,
        })
    end,
}
