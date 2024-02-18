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
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                python = { 'isort', 'black' },
            },
        },
    },
    {
        'MeanderingProgrammer/py-requirements.nvim',
        dev = true,
        dependencies = { 'nvim-lua/plenary.nvim', 'hrsh7th/nvim-cmp' },
        config = function()
            local requirements = require('py-requirements')
            requirements.setup({
                file_patterns = { '.*requirements.*.txt' },
            })

            require('which-key').register({
                ['<leader>r'] = {
                    name = 'requirements',
                    u = { requirements.upgrade, 'Upgrade' },
                    U = { requirements.upgrade_all, 'Upgrade All' },
                    d = { requirements.show_description, 'Show Description' },
                },
            })
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        opts = function(_, opts)
            table.insert(opts.sources, { name = 'py-requirements' })
        end,
    },
}
