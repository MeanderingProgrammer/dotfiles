return {
    'nvimtools/none-ls.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
        local function null_ls_filter(client)
            return client.name == 'null-ls'
        end
        local function save_on_write(client, bufnr)
            if not client.supports_method('textDocument/formatting') then
                return
            end
            local ignore_auto_format = { 'markdown' }
            if vim.tbl_contains(ignore_auto_format, vim.bo[bufnr].filetype) then
                return
            end
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr, filter = null_ls_filter })
                end,
            })
        end

        local null_ls = require('null-ls')
        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics

        local languages = {
            lua = { formatting.stylua },
            go = { formatting.gofmt },
            rust = {
                formatting.rustfmt.with({ extra_args = { '--edition=2021' } }),
            },
            ocaml = { formatting.ocamlformat },
            typescript = {
                formatting.prettier.with({ extra_filetypes = { 'svelte' } }),
                diagnostics.eslint,
            },
            python = {
                formatting.black,
                -- Too noisy for the time being, probably just not well configured
                -- diagnostics.mypy,
            },
        }
        local sources = {}
        for _, language_sources in pairs(languages) do
            vim.list_extend(sources, language_sources)
        end

        null_ls.setup({
            sources = sources,
            on_attach = save_on_write,
        })
    end,
}
