return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'nix' },
        },
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
