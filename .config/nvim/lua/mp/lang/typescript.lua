local utils = require('mp.lib.utils')

require('mp.lib.lang').add({
    parser = {
        css = { install = true },
        html = { install = true },
        javascript = { install = true },
        jsdoc = { install = true },
        jsx = { install = true },
        prisma = { install = true },
        scss = { install = true },
        svelte = { install = true },
        tsx = { install = true },
        typescript = { install = true },
        vue = { install = true },
    },
    tool = {
        ['eslint-lsp'] = { install = vim.g.has.npm },
        ['svelte-language-server'] = { install = vim.g.has.npm },
        ['tailwindcss-language-server'] = { install = vim.g.has.npm },
        ['typescript-language-server'] = { install = vim.g.has.npm },
        ['prettierd'] = { install = vim.g.has.npm },
    },
    lsp = {
        eslint = {},
        svelte = {},
        tailwindcss = {},
        ts_ls = {},
    },
    format = {
        prettierd = {
            filetypes = {
                'css',
                'html',
                'javascript',
                'javascriptreact',
                'svelte',
                'typescript',
                'typescriptreact',
                'vue',
            },
            init = function()
                -- only run when project local prettier is available
                vim.env.PRETTIERD_LOCAL_PRETTIER_ONLY = 1

                -- prettierd not picking up certain changes
                -- https://github.com/fsouza/prettierd/issues/719
                vim.api.nvim_create_autocmd('BufWritePost', {
                    group = utils.augroup('mp.prettierd'),
                    pattern = '*prettier*',
                    callback = function()
                        utils.system({ 'prettierd', 'restart' })
                    end,
                })
            end,
        },
    },
})
