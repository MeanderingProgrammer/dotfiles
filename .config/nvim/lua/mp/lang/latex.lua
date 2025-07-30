require('mp.lang').add({
    parser = {
        latex = { install = true },
    },
    tool = {
        ['texlab'] = { install = vim.g.pc },
    },
    lsp = {
        texlab = {},
    },
})
