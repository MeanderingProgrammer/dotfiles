return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { 'vim', 'vimdoc' })
            vim.list_extend(opts.ensure_installed, { 'lua', 'luadoc', 'query' })
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
}
