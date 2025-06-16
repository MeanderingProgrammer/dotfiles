local util = require('mp.util')

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
            install = util.pc({
                'eslint-lsp',
                'svelte-language-server',
                'typescript-language-server',
                'prettierd',
            }),
            formatters = {
                javascript = util.pc({ 'prettierd' }),
                typescript = util.pc({ 'prettierd' }),
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            eslint = { enabled = vim.g.pc },
            svelte = { enabled = vim.g.pc },
            ts_ls = {
                enabled = vim.g.pc,
                settings = {
                    implicitProjectConfiguration = {
                        checkJs = true,
                    },
                },
            },
        },
    },
}
