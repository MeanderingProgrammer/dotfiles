return {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require('mp.configs.nvim-treesitter-textobjects')
    end,
}
