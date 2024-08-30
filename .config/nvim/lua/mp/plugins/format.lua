local utils = require('mp.utils')

return {
    'stevearc/conform.nvim',
    dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    opts = {
        formatters_by_ft = {},
        disabled_fts = {},
    },
    config = function(_, opts)
        local filtered = utils.filter_packages(opts.formatters_by_ft)
        local mason_formatters, system_formatters = filtered.mason, filtered.system
        require('mason-tool-installer').setup({
            ensure_installed = utils.flat_values(mason_formatters),
        })
        local formatters = vim.tbl_deep_extend('force', mason_formatters, system_formatters)

        require('conform').setup({
            formatters_by_ft = formatters,
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
