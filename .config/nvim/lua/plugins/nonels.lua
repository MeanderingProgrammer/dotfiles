return {
    'nvimtools/none-ls.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local null_ls = require('null-ls')

        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics

        local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

        null_ls.setup({
            sources = {
                formatting.stylua,
                formatting.gofmt,
                formatting.rustfmt.with({
                    extra_args = { '--edition=2021' },
                }),
                formatting.prettier.with({
                    extra_filetypes = { 'svelte' },
                }),
                diagnostics.eslint,
                formatting.black,
                diagnostics.mypy,
            },
            on_attach = function(current_client, bufnr)
                if current_client.supports_method('textDocument/formatting') then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({
                                bufnr = bufnr,
                                filter = function(client)
                                    return client.name == 'null-ls'
                                end,
                            })
                        end,
                    })
                end
            end,
        })
    end,
}
