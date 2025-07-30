require('mp.lang').add({
    parser = {
        ruby = { install = true },
    },
    tool = {
        ['ruby-lsp'] = { install = vim.g.has.gem },
    },
    lsp = {
        ruby_lsp = {},
    },
})
