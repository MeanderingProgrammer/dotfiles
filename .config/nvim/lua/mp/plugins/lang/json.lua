return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'jq', 'json', 'json5', 'jsonc' },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            opts.servers.jsonls = {}
        end,
    },
}
