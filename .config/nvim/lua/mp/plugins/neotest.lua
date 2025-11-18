return {
    'nvim-neotest/neotest',
    dependencies = {
        'antoinemadec/FixCursorHold.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-neotest/neotest-plenary',
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
            desc = 'summary toggle',
        },
    },
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('neotest').setup({
            adapters = {
                require('neotest-plenary'),
            },
        })
    end,
}
