return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { 'vim', 'vimdoc' })
            vim.list_extend(opts.ensure_installed, { 'lua', 'query' })
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
            linter_override = {
                luacheck = function(config)
                    table.insert(config.args, 1, '--default-config')
                    table.insert(config.args, 2, require('mp.utils').lint_config('.luacheckrc'))
                end,
            },
        },
    },
}
