return {
    setup = function()
        local languages = {
            go = { require('efmls-configs.formatters.gofmt') },
            lua = { require('efmls-configs.formatters.stylua') },
            python = { require('efmls-configs.linters.mypy') },
            rust = { require('efmls-configs.formatters.rustfmt') },
            typescript = {
                require('efmls-configs.linters.eslint'),
                require('efmls-configs.formatters.prettier'),
            },
        }
        require('lspconfig').efm.setup({
            filetypes = vim.tbl_keys(languages),
            settings = {
                rootMarkers = { '.git/' },
                languages = languages,
            },
            init_options = {
                documentFormatting = true,
                documentRangeFormatting = true,
            },
        })
    end,
    update_on_write = function()
        local lsp_fmt_group = vim.api.nvim_create_augroup('LspFormatGroup', {})
        vim.api.nvim_create_autocmd('BufWritePost', {
            group = lsp_fmt_group,
            callback = function()
                local efm = vim.lsp.get_active_clients({ name = 'efm' })
                if vim.tbl_isempty(efm) then
                    return
                end
                vim.lsp.buf.format({ name = 'efm' })
            end,
        })
    end,
}
