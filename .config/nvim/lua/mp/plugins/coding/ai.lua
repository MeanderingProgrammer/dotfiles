return {
    {
        'Exafunction/codeium.nvim',
        build = ':Codeium Auth',
        dependencies = { 'nvim-lua/plenary.nvim', 'hrsh7th/nvim-cmp' },
        config = function()
            require('codeium').setup({})
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        opts = function(_, opts)
            table.insert(opts.sources, 1, { name = 'codeium' })
        end,
    },
}
