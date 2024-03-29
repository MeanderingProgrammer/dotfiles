return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            local c_grammars = { 'c', 'c_sharp', 'cmake', 'cpp', 'make' }
            vim.list_extend(opts.ensure_installed, c_grammars)
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            opts.servers.csharp_ls = {}
        end,
    },
}
