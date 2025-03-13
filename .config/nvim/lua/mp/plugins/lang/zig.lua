return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { languages = { 'zig' } },
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            if not vim.g.android then
                table.insert(opts.install, { 'zls', version = '0.13.0' })
            end
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            if not vim.g.android then
                opts.servers.zls = {}
            end
        end,
    },
}
