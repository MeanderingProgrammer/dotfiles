return {
    {
        'nvim-treesitter/nvim-treesitter',
        ---@type mp.ts.Config
        opts = {
            python = { install = true },
            requirements = { install = true },
        },
    },
    {
        'mason-org/mason.nvim',
        ---@type mp.mason.Config
        opts = {
            ['pyright'] = { install = vim.g.has.npm },
            ['ruff'] = { install = vim.g.has.pip },
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            pyright = {
                settings = {
                    python = {
                        analysis = {
                            diagnosticMode = 'workspace',
                        },
                    },
                },
            },
        },
    },
    {
        'stevearc/conform.nvim',
        ---@type mp.conform.Config
        opts = {
            ruff_fix = { cmd = 'ruff', filetypes = { 'python' } },
            ruff_format = { cmd = 'ruff', filetypes = { 'python' } },
            ruff_organize_imports = { cmd = 'ruff', filetypes = { 'python' } },
        },
    },
    {
        'mfussenegger/nvim-lint',
        ---@type mp.lint.Config
        opts = {
            ruff = { filetypes = { 'python' } },
        },
    },
    {
        'MeanderingProgrammer/py-requirements.nvim',
        dev = true,
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            local requirements = require('py-requirements')
            requirements.setup({
                file_patterns = { '.*requirements.*.txt' },
                filter = { final_release = true },
            })

            ---@param lhs string
            ---@param rhs function
            ---@param desc string
            local function map(lhs, rhs, desc)
                vim.keymap.set('n', lhs, rhs, { desc = desc })
            end
            map('<leader>rd', requirements.show_description, 'Show Description')
            map('<leader>ru', requirements.upgrade, 'Upgrade')
            map('<leader>rU', requirements.upgrade_all, 'Upgrade All')
        end,
    },
}
