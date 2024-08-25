return {
    'stevearc/conform.nvim',
    enabled = not require('mp.utils').is_termux,
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
                local disabled_ft = vim.tbl_contains(opts.disabled_fts, ft)
                if disabled_ft then
                    return nil
                end
                local name = vim.api.nvim_buf_get_name(bufnr)
                local disabled_name = name:find('/open-source/', 1, true)
                if disabled_name then
                    return nil
                end
                return { lsp_format = 'fallback' }
            end,
        })
    end,
}
