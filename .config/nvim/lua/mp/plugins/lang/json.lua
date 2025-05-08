return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'jq', 'json', 'json5', 'jsonc' },
        },
    },
    {
        'mason-org/mason.nvim',
        opts = function(_, opts)
            if not vim.g.android then
                opts.install[#opts.install + 1] = 'json-lsp'
            end
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            if not vim.g.android then
                opts.servers.jsonls = {}
            end
        end,
    },
}
