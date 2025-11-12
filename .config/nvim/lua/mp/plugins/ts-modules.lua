local lang = require('mp.lib.lang')

return {
    'MeanderingProgrammer/treesitter-modules.nvim',
    dev = true,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        local configs = lang.parsers()

        for name, config in pairs(configs) do
            local filetypes = config.filetypes
            if filetypes then
                vim.treesitter.language.register(name, filetypes)
            end
        end

        require('treesitter-modules').setup({
            ensure_installed = vim.tbl_keys(configs),
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
