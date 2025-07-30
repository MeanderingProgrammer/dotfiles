return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    dependencies = {
        { 'MeanderingProgrammer/treesitter-modules.nvim', dev = true },
    },
    config = function()
        require('nvim-treesitter').setup({})

        local install = require('mp.lang').parsers()

        require('treesitter-modules').setup({
            ensure_installed = install,
            highlight = { enable = true },
            indent = { enable = true },
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
