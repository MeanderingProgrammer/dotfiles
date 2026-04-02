require('mp.lib.langs').add({
    parser = {
        zig = { install = true },
    },
    tool = {
        zls = { install = vim.g.pc and vim.g.personal },
    },
    lsp = {
        zls = {},
    },
})
