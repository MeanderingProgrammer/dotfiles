return {
    {
        'Exafunction/codeium.nvim',
        event = 'VeryLazy',
        build = ':Codeium Auth',
        dependencies = { 'nvim-lua/plenary.nvim', 'hrsh7th/nvim-cmp' },
        cond = function()
            return vim.fn.has('mac') == 1
        end,
        config = function()
            local utils = require('mp.utils')
            if not utils.challenge_mode() then
                require('codeium').setup({})
            end
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        opts = function(_, opts)
            table.insert(opts.sources, 1, { name = 'codeium' })
        end,
    },
}
