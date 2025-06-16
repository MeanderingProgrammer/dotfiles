local util = require('mp.util')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'markdown', 'markdown_inline' },
        },
    },
    {
        'mason-org/mason.nvim',
        opts = {
            install = util.pc(
                { 'markdownlint', 'marksman' },
                { 'markdownlint' }
            ),
            linters = {
                markdown = { 'markdownlint' },
            },
            linter_overrides = {
                markdownlint = function(linter)
                    local args = {
                        '--config',
                        util.lint_config('markdownlint.yaml'),
                    }
                    linter.args = vim.list_extend(linter.args or {}, args)
                end,
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            marksman = util.pc({}),
        },
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
