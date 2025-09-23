local lang = require('mp.lib.lang')

return {
    'MeanderingProgrammer/treesitter-modules.nvim',
    dev = true,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        local configs = lang.parsers()
        local names = lang.install(configs)

        for _, name in ipairs(names) do
            local filetypes = configs[name].filetypes
            if filetypes then
                vim.treesitter.language.register(name, filetypes)
            end
        end

        require('treesitter-modules').setup({
            ensure_installed = names,
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
