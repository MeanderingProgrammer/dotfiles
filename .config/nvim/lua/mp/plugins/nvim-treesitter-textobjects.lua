return {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require('mp.configs.nvim-treesitter-textobjects')
    end,
}
