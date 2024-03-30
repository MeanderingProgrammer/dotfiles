return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            local lua_grammars = { 'lua', 'query', 'vim', 'vimdoc' }
            vim.list_extend(opts.ensure_installed, lua_grammars)
        end,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'folke/neoconf.nvim', config = true },
            { 'folke/neodev.nvim', config = true },
        },
        opts = function(_, opts)
            opts.servers.lua_ls = {}
        end,
    },
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                lua = { 'stylua' },
            },
        },
    },
    {
        'mfussenegger/nvim-lint',
        opts = {
            linters_by_ft = {
                lua = { 'luacheck' },
            },
            linter_configs = {
                luacheck = {
                    args = {
                        '--config',
                        require('mp.utils').lint_config('.luacheckrc'),
                    },
                },
            },
        },
    },
}
