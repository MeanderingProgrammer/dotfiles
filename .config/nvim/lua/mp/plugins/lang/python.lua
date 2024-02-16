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

            local map = require('mp.config.utils').leader_map
            map('ru', requirements.upgrade, 'Requirements: Upgrade')
            map('rU', requirements.upgrade_all, 'Requirements: Upgrade All')
            map('rd', requirements.show_description, 'Requirements: Show Description')
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        opts = function(_, opts)
            table.insert(opts.sources, { name = 'py-requirements' })
        end,
    },
}
