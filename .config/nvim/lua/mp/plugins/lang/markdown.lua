local utils = require('mp.utils')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'markdown', 'markdown_inline' },
        },
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            if not vim.g.android then
                table.insert(opts.install, 'marksman')
            end
            table.insert(opts.install, 'markdownlint')
            opts.linters.markdown = { 'markdownlint' }
            opts.linter_overrides.markdownlint = function(linter)
                local config = utils.lint_config('markdownlint.yaml')
                linter.args = vim.list_extend(linter.args or {}, { '--config', config })
            end
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            if not vim.g.android then
                opts.servers.marksman = {}
            end
        end,
    },
    {
        '3rd/image.nvim',
        enabled = false,
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
        'MeanderingProgrammer/render-markdown.nvim',
        dev = true,
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
        config = function()
            require('render-markdown').setup({
                file_types = { 'markdown', 'gitcommit' },
                html = { enabled = false },
            })
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        optional = true,
        opts = function(_, opts)
            table.insert(opts.sources, { name = 'render-markdown' })
        end,
    },
    {
        'saghen/blink.cmp',
        optional = true,
        opts = {
            providers = {
                markdown = {
                    name = 'RenderMarkdown',
                    module = 'render-markdown.integ.blink',
                    fallbacks = { 'lsp' },
                },
            },
        },
    },
}
