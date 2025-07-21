return {
    'nvim-neotest/neotest',
    dependencies = {
        'antoinemadec/FixCursorHold.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-neotest/nvim-nio',
        'nvim-treesitter/nvim-treesitter',
    },
    keys = {
        {
            '<leader>nr',
            function()
                require('neotest').run.run(vim.fn.expand('%'))
            end,
            desc = 'run file',
        },
        {
            '<leader>ns',
            function()
                require('neotest').summary.toggle()
            end,
            desc = 'toggle summary',
        },
    },
    opts = {
        adapters = {},
    },
    config = function(_, opts)
        require('neotest').setup(opts)
    end,
}
