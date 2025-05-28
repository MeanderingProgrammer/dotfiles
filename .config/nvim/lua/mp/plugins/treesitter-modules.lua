return {
    'MeanderingProgrammer/treesitter-modules.nvim',
    dev = true,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require('treesitter-modules').setup({
            highlight = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<C-v>',
                    node_incremental = 'v',
                    node_decremental = 'V',
                    scope_incremental = false,
                },
            },
        })
    end,
}
