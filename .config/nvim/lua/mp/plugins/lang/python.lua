return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'python', 'requirements' },
        },
    },
    {
        'mason-org/mason.nvim',
        opts = {
            install = { 'pyright', 'black', 'isort' },
            formatters = {
                python = { 'black', 'isort' },
            },
            formatter_overrides = {
                isort = {
                    prepend_args = { '--profile', 'black' },
                },
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            pyright = {
                enabled = true,
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
