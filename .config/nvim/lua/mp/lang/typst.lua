require('mp.lib.langs').add({
    parser = {
        typst = { install = true },
    },
    tool = {
        tinymist = { install = vim.g.pc },
        prettypst = { install = vim.g.has.cargo },
    },
    lsp = {
        tinymist = {},
    },
    format = {
        prettypst = { filetypes = { 'typst' } },
    },
})
