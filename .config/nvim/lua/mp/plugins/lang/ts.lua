local utils = require('mp.utils')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            vim.list_extend(opts.languages, { 'html', 'css', 'scss' })
            vim.list_extend(opts.languages, { 'javascript', 'jsdoc', 'typescript' })
            vim.list_extend(opts.languages, { 'svelte', 'vue' })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            if utils.is_android then
                return
            end
            opts.mason.eslint = {}
            opts.mason.svelte = {}
            opts.mason.tailwindcss = {}
            opts.mason.tsserver = {
                settings = {
                    implicitProjectConfiguration = {
                        checkJs = true,
                    },
                },
            }
        end,
    },
    {
        'williamboman/mason.nvim',
        init = function()
            -- Avoid running when project does not use prettier
            vim.env.PRETTIERD_LOCAL_PRETTIER_ONLY = 1

            -- Due to prettierd not picking up changes
            -- https://github.com/fsouza/prettierd/issues/719
            vim.api.nvim_create_autocmd('BufWritePost', {
                group = vim.api.nvim_create_augroup('RestartPrettierd', { clear = true }),
                pattern = '*prettier*',
                callback = function()
                    vim.fn.system('prettierd restart')
                end,
            })
        end,
        opts = function(_, opts)
            if utils.is_android then
                return
            end
            local formatters = { 'prettierd' }
            vim.list_extend(opts.ensure_installed, formatters)
            opts.formatters.javascript = formatters
            opts.formatters.typescript = formatters
        end,
    },
}
