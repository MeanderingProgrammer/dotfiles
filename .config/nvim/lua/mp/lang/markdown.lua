local utils = require('mp.lib.utils')

require('mp.lib.lang').add({
    parser = {
        markdown = { install = true },
        markdown_inline = { install = true },
    },
    tool = {
        ['markdownlint'] = { install = vim.g.has.npm },
        ['marksman'] = { install = vim.g.pc },
    },
    lsp = {
        marksman = {},
    },
    lint = {
        markdownlint = {
            filetypes = { 'markdown' },
            override = function(linter)
                local args = {
                    '--config',
                    utils.lint_config('markdownlint.yaml'),
                }
                linter.args = vim.list_extend(linter.args or {}, args)
            end,
        },
    },
})
