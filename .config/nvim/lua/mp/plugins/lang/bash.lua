return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            vim.list_extend(opts.languages, { 'bash' })
        end,
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
        'mfussenegger/nvim-lint',
        opts = {
            linters_by_ft = {
                bash = { 'shellcheck' },
                sh = { 'shellcheck' },
                zsh = { 'shellcheck' },
            },
        },
    },
}
