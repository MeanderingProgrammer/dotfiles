require('mp.lib.langs').add({
    parser = {
        latex = { install = vim.g.pc },
    },
    tool = {
        texlab = { install = vim.g.pc and vim.g.personal },
    },
    lsp = {
        texlab = {},
    },
})
