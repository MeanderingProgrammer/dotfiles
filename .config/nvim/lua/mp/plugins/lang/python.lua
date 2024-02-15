return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { 'python', 'requirements' })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            servers = {
                pyright = {},
            },
        },
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            {
                'MeanderingProgrammer/py-requirements.nvim',
                dev = true,
                dependencies = { 'nvim-lua/plenary.nvim' },
                config = function()
                    ---@param lhs string
                    ---@param rhs fun()
                    ---@param desc string
                    local function map(lhs, rhs, desc)
                        vim.keymap.set('n', '<leader>' .. lhs, rhs, { silent = true, desc = 'Requirements: ' .. desc })
                    end
                    local requirements = require('py-requirements')
                    map('ru', requirements.upgrade, 'Upgrade')
                    map('rU', requirements.upgrade_all, 'Upgrade All')
                    map('rd', requirements.show_description, 'Show Description')
                    requirements.setup({
                        file_patterns = { '.*requirements.*.txt' },
                    })
                end,
            },
        },
        opts = function(_, opts)
            table.insert(opts.sources, { name = 'py-requirements' })
        end,
    },
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                python = { 'isort', 'black' },
            },
        },
    },
}
