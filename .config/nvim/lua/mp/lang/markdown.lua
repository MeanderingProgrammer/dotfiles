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
            args = function()
                local file = utils.path('config', 'lint', 'markdownlint.yaml')
                ---@type string[]
                return { '--config', file }
            end,
        },
    },
})
