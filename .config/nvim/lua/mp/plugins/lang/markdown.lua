return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { 'markdown', 'markdown_inline' })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            opts.servers.marksman = {}
        end,
    },
    {
        'mfussenegger/nvim-lint',
        opts = {
            linters_by_ft = {
                markdown = { 'markdownlint' },
            },
            linter_configs = {
                markdownlint = {
                    args = {
                        '--config',
                        require('mp.utils').lint_config('markdownlint.yaml'),
                    },
                },
            },
        },
    },
    {
        'MeanderingProgrammer/markdown.nvim',
        dev = true,
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('render-markdown').setup({})
        end,
    },
}
