return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    dependencies = { 'mason-org/mason.nvim' },
    config = function()
        require('nvim-treesitter').setup({})
    end,
}
