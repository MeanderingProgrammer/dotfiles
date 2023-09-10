return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufReadPost',
    dependencies = {
        'nvim-treesitter/playground',
    },
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = 'all',
            highlight = { enable = true },
        })
    end,
}
