require('mp.lib.langs').add({
    parser = {
        ruby = { install = true },
    },
    tool = {
        ['ruby-lsp'] = { install = vim.g.has.gem and vim.g.personal },
    },
    lsp = {
        ruby_lsp = { cmd = 'ruby-lsp' },
    },
})
