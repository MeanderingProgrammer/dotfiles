return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            vim.list_extend(opts.languages, {
                'css',
                'html',
                'javascript',
                'jsdoc',
                'scss',
                'svelte',
                'typescript',
                'vue',
            })
        end,
    },
    {
        'mason-org/mason.nvim',
        init = function()
            -- avoid running when project does not use prettier
            vim.env.PRETTIERD_LOCAL_PRETTIER_ONLY = 1

            -- due to prettierd not picking up changes
            -- https://github.com/fsouza/prettierd/issues/719
            vim.api.nvim_create_autocmd('BufWritePost', {
                group = vim.api.nvim_create_augroup('RestartPrettierd', {}),
                pattern = '*prettier*',
                callback = function()
                    vim.fn.system('prettierd restart')
                end,
            })
        end,
        opts = function(_, opts)
            if not vim.g.android then
                opts.install[#opts.install + 1] = 'eslint-lsp'
                opts.install[#opts.install + 1] = 'svelte-language-server'
                opts.install[#opts.install + 1] = 'typescript-language-server'
                opts.install[#opts.install + 1] = 'prettierd'
                opts.formatters.javascript = { 'prettierd' }
                opts.formatters.typescript = { 'prettierd' }
            end
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            if not vim.g.android then
                opts.servers.eslint = {}
                opts.servers.svelte = {}
                opts.servers.ts_ls = {
                    settings = {
                        implicitProjectConfiguration = {
                            checkJs = true,
                        },
                    },
                }
            end
        end,
    },
}
