return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            vim.list_extend(opts.languages, { 'markdown', 'markdown_inline' })
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
            linter_override = {
                markdownlint = function(linter)
                    local config = require('mp.utils').lint_config('markdownlint.yaml')
                    linter.args = { '--config', config }
                end,
            },
        },
    },
    {
        '3rd/image.nvim',
        enabled = vim.fn.has('mac') == 1,
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require('image').setup({
                integrations = {
                    markdown = {
                        only_render_image_at_cursor = true,
                    },
                },
            })
        end,
    },
    {
        'MeanderingProgrammer/markdown.nvim',
        dev = true,
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
        config = function()
            require('render-markdown').setup({})
        end,
    },
}
