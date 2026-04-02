return {
    'mfussenegger/nvim-dap',
    dependencies = { 'mason-org/mason.nvim' },
    config = function()
        require('mp.configs.nvim-dap')
    end,
}
