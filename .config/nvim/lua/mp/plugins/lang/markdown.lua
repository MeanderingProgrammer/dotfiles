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
                opts.install[#opts.install + 1] = 'marksman'
            end
            opts.install[#opts.install + 1] = 'markdownlint'
            opts.linters.markdown = { 'markdownlint' }
            opts.linter_overrides.markdownlint = function(linter)
                local args = {
                    '--config',
                    require('mp.util').lint_config('markdownlint.yaml'),
                }
                linter.args = vim.list_extend(linter.args or {}, args)
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
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'echasnovski/mini.nvim',
        },
        config = function()
            local markdown = require('render-markdown')
            markdown.setup({
                file_types = { 'markdown', 'gitcommit' },
                html = { enabled = false },
                completions = { lsp = { enabled = true } },
            })

            ---@param lhs string
            ---@param rhs function
            ---@param desc string
            local function map(lhs, rhs, desc)
                vim.keymap.set('n', lhs, rhs, { desc = desc })
            end
            map('<leader>md', markdown.debug, 'debug')
            map('<leader>mt', markdown.toggle, 'toggle')
        end,
    },
}
