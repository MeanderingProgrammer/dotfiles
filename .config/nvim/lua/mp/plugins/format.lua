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
        local ensure_installed = {}
        for _, formatters in pairs(opts.formatters_by_ft) do
            for _, formatter in ipairs(formatters) do
                if not vim.tbl_contains(ensure_installed, formatter) then
                    table.insert(ensure_installed, formatter)
                end
            end
        end
        require('mason-tool-installer').setup({
            ensure_installed = ensure_installed,
        })

        require('conform').setup(opts)
    end,
}
