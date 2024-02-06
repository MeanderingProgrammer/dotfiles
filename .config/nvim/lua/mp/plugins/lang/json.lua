return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { 'jq', 'json', 'jsonc' })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            servers = {
                jsonls = {},
            },
        },
    },
}
