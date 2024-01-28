return {
    'stevearc/conform.nvim',
    dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    config = function()
        require('mason-tool-installer').setup({
            ensure_installed = {
                'black',
                'gofumpt',
                'goimports',
                'isort',
                'prettier',
                'stylua',
            },
        })
        require('conform').setup({
            formatters_by_ft = {
                go = { 'goimports', 'gofumpt' },
                lua = { 'stylua' },
                ocaml = { 'ocamlformat' },
                python = { 'isort', 'black' },
                svelte = { 'prettier' },
                typescript = { 'prettier' },
            },
            format_after_save = {
                lsp_fallback = true,
            },
        })
    end,
}
