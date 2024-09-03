local utils = require('mp.utils')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { languages = { 'bash' } },
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            opts.mason.bashls = {
                filetypes = { 'sh', 'zsh' },
            }
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            if utils.is_android then
                return
            end
            vim.list_extend(opts.ensure_installed, { 'shellcheck' })
            opts.linters.bash = { 'shellcheck' }
            opts.linters.sh = { 'shellcheck' }
            opts.linters.zsh = { 'shellcheck' }
        end,
    },
}
