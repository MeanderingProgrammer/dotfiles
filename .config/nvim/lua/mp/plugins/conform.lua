return {
    'stevearc/conform.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    config = function()
        require('mp.configs.conform')
    end,
}
