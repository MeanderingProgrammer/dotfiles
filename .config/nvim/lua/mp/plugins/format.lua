return {
    'stevearc/conform.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
        require('mason-tool-installer').setup({
            ensure_installed = {
                'black',
                'google-java-format',
                'isort',
                'prettier',
                'stylua',
            },
        })
        require('conform').setup({
            formatters_by_ft = {
                java = { 'google-java-format' },
                lua = { 'stylua' },
                ocaml = { 'ocamlformat' },
                python = { 'isort', 'black' },
                svelte = { 'prettier' },
                typescript = { 'prettier' },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        })
    end,
}
