local utils = require('mp.utils')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'markdown', 'markdown_inline' },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            if utils.is_android then
                return
            end
            opts.mason.marksman = {}
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            local linters = { 'markdownlint' }
            vim.list_extend(opts.ensure_installed, linters)
            opts.linters.markdown = linters
            opts.linter_overrides.markdownlint = function(linter)
                local config = utils.lint_config('markdownlint.yaml')
                linter.args = { '--config', config }
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
            })
        end,
    },
}
