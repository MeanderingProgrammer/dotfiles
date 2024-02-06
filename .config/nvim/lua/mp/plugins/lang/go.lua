return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            local go_grammars = { 'go', 'gomod', 'gowork', 'gosum' }
            vim.list_extend(opts.ensure_installed, go_grammars)
        end,
    },
}
