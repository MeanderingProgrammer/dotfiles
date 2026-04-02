return {
    'mfussenegger/nvim-lint',
    dependencies = { 'mason-org/mason.nvim' },
    config = function()
        require('mp.configs.nvim-lint')
    end,
}
