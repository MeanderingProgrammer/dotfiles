return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { languages = { 'bash' } },
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            opts.install[#opts.install + 1] = 'bash-language-server'
            if not vim.g.android then
                opts.linters.bash = { 'shellcheck' }
                opts.linters.sh = { 'shellcheck' }
                opts.linters.zsh = { 'shellcheck' }
            end
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
}
