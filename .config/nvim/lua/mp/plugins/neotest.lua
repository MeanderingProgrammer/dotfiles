return {
    'nvim-neotest/neotest',
    dependencies = {
        'antoinemadec/FixCursorHold.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-neotest/nvim-nio',
        'nvim-treesitter/nvim-treesitter',
    },
    opts = {
        adapters = {},
    },
    config = function(_, opts)
        local neotest = require('neotest')
        neotest.setup(opts)

        vim.keymap.set('n', '<leader>nr', function()
            neotest.run.run(vim.fn.expand('%'))
        end, { desc = 'neotest run file' })
    end,
}
