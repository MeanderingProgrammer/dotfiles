return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'bash' },
        },
    },
    {
        'mason-org/mason.nvim',
        ---@type mp.mason.Config
        opts = {
            ['bash-language-server'] = { install = true },
            shellcheck = { install = vim.g.computer },
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            bashls = {
                enabled = true,
                filetypes = { 'bash', 'sh', 'zsh' },
            },
        },
    },
    {
        'mfussenegger/nvim-lint',
        ---@type mp.lint.Config
        opts = {
            shellcheck = { filetypes = { 'bash', 'sh', 'zsh' } },
        },
    },
}
