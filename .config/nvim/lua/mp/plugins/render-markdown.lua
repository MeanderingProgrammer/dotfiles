return {
    'MeanderingProgrammer/render-markdown.nvim',
    dev = vim.g.personal,
    dependencies = {
        'nvim-mini/mini.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    config = function()
        require('mp.configs.render-markdown')
    end,
}
