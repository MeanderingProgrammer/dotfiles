require('mp.lib.lang').add({
    parser = {
        latex = { install = vim.g.pc },
    },
    tool = {
        ['texlab'] = { install = vim.g.pc },
    },
    lsp = {
        texlab = {},
    },
})
