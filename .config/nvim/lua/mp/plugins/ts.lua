---@alias mp.ts.Config table<string, mp.ts.Tool>

---@class mp.ts.Tool: mp.install.Tool

return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    dependencies = {
        { 'MeanderingProgrammer/treesitter-modules.nvim', dev = true },
    },
    ---@type mp.ts.Config
    opts = {},
    ---@param opts mp.ts.Config
    config = function(_, opts)
        require('nvim-treesitter').setup({})

        local install = require('mp.util').tool.install(opts)

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
