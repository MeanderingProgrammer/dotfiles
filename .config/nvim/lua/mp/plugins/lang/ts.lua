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
        opts = {
            install = require('mp.util').pc({
                'eslint-lsp',
                'svelte-language-server',
                'typescript-language-server',
                'prettierd',
            }),
            formatters = {
                javascript = require('mp.util').pc({ 'prettierd' }),
                typescript = require('mp.util').pc({ 'prettierd' }),
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            eslint = require('mp.util').pc({}),
            svelte = require('mp.util').pc({}),
            ts_ls = require('mp.util').pc({
                settings = {
                    implicitProjectConfiguration = {
                        checkJs = true,
                    },
                },
            }),
        },
    },
}
