return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            local lua_grammars = { 'lua', 'query', 'vim', 'vimdoc' }
            vim.list_extend(opts.ensure_installed, lua_grammars)
        end,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'folke/neoconf.nvim', config = true },
            { 'folke/neodev.nvim', config = true },
        },
        opts = {
            servers = {
                lua_ls = {},
            },
        },
    },
}
