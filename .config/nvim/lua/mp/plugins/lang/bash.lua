return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'bash' },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            opts.servers.bashls = {
                filetypes = { 'sh', 'zsh' },
            }
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = {
            linters = {
                bash = { 'shellcheck' },
                sh = { 'shellcheck' },
                zsh = { 'shellcheck' },
            },
        },
    },
}
