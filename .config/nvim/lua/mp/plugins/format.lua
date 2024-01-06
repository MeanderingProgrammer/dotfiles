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
                'ktlint',
                'prettier',
                'stylua',
            },
        })
        require('conform').setup({
            formatters_by_ft = {
                java = { 'google-java-format' },
                kotlin = { 'ktlint' },
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
