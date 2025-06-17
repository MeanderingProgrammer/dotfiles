return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = {
                'css',
                'html',
                'javascript',
                'jsdoc',
                'scss',
                'svelte',
                'typescript',
                'vue',
            },
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
            ['eslint-lsp'] = { install = vim.g.computer },
            ['svelte-language-server'] = { install = vim.g.computer },
            ['typescript-language-server'] = { install = vim.g.computer },
            prettierd = { install = vim.g.computer },
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            eslint = { enabled = vim.g.computer },
            svelte = { enabled = vim.g.computer },
            ts_ls = {
                enabled = vim.g.computer,
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
