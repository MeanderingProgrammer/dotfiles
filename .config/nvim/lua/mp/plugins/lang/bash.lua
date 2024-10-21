local utils = require('mp.utils')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { languages = { 'bash' } },
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            table.insert(opts.install, 'bash-language-server')
            if not utils.is_android then
                table.insert(opts.install, 'shellcheck')
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
