return {
    {
        'nvim-treesitter/nvim-treesitter',
        ---@type mp.ts.Config
        opts = {
            bash = { install = true },
        },
    },
    {
        'mason-org/mason.nvim',
        ---@type mp.mason.Config
        opts = {
            ['bash-language-server'] = { install = vim.g.has.npm },
            shellcheck = { install = vim.g.computer },
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            bashls = {
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
