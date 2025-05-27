return {
    'MeanderingProgrammer/treesitter-modules.nvim',
    dev = true,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require('treesitter-modules').setup({
            highlight = { enable = true },
        })
    end,
}
