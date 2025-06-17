return {
    {
        'nvim-treesitter/nvim-treesitter',
        ---@type mp.ts.Config
        opts = {
            css = { install = true },
            html = { install = true },
            javascript = { install = true },
            jsdoc = { install = true },
            scss = { install = true },
            svelte = { install = true },
            typescript = { install = true },
            vue = { install = true },
        },
    },
    {
        'mason-org/mason.nvim',
        init = function()
            -- avoid running when project does not use prettier
            vim.env.PRETTIERD_LOCAL_PRETTIER_ONLY = 1

            -- due to prettierd not picking up changes
            -- https://github.com/fsouza/prettierd/issues/719
            vim.api.nvim_create_autocmd('BufWritePost', {
                group = vim.api.nvim_create_augroup('user.prettierd', {}),
                pattern = '*prettier*',
                callback = function()
                    vim.fn.system('prettierd restart')
                end,
            })
        end,
        ---@type mp.mason.Config
        opts = {
            ['eslint-lsp'] = { install = vim.g.has.npm },
            ['svelte-language-server'] = { install = vim.g.has.npm },
            ['typescript-language-server'] = { install = vim.g.has.npm },
            prettierd = { install = vim.g.has.npm },
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            eslint = {},
            svelte = {},
            ts_ls = {
                settings = {
                    implicitProjectConfiguration = {
                        checkJs = true,
                    },
                },
            },
        },
    },
    {
        'stevearc/conform.nvim',
        ---@type mp.conform.Config
        opts = {
            prettierd = { filetypes = { 'javascript', 'typescript' } },
        },
    },
}
