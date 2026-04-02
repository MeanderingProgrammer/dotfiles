local Keymap = require('mp.lib.keymap')
local markdown = require('render-markdown')

markdown.setup({
    file_types = { 'markdown', 'gitcommit' },
    html = { enabled = false },
    completions = { lsp = { enabled = true } },
})

Keymap.new({ prefix = '<leader>m' })
    :n('d', markdown.debug, 'debug')
    :n('t', markdown.toggle, 'toggle')
