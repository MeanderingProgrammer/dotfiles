return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = { 'mason-org/mason.nvim' },
    config = function()
        require('nvim-treesitter').setup({})
    end,
}
