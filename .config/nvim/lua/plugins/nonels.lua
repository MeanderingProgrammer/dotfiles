return {
    'nvimtools/none-ls.nvim',
    lazy = false,
    config = function()
        local null_ls = require('null-ls')
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.gofmt,
                null_ls.builtins.formatting.rustfmt,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.diagnostics.eslint,
                null_ls.builtins.diagnostics.mypy,
                null_ls.builtins.completion.spell,
            },
            on_attach = function(client, bufnr)
                if client.supports_method('textDocument/formatting') then
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        group = vim.api.nvim_create_augroup('LspFormatting', { clear = true }),
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = false })
                        end,
                    })
                end
            end,
        })
    end,
}
