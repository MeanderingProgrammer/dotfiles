local utils = require('mp.utils')

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
            local linters = { 'shellcheck' }
            vim.list_extend(opts.ensure_installed, linters)
            opts.linters.bash = linters
            opts.linters.sh = linters
            opts.linters.zsh = linters
        end,
    },
}
