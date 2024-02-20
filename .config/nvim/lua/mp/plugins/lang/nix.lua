return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { 'nix' })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            if vim.fn.has('mac') == 1 then
                opts.servers.nil_ls = {}
            end
        end,
    },
}
