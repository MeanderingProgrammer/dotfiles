return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'python', 'requirements' },
        },
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            table.insert(opts.install, 'pyright')
            vim.list_extend(opts.install, { 'isort', 'black' })
            opts.formatters.python = { 'isort', 'black' }
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            opts.servers.pyright = {}
        end,
    },
    {
        'MeanderingProgrammer/py-requirements.nvim',
        dev = true,
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'hrsh7th/nvim-cmp' },
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
    {
        'hrsh7th/nvim-cmp',
        opts = function(_, opts)
            table.insert(opts.sources, { name = 'py-requirements' })
        end,
    },
}
