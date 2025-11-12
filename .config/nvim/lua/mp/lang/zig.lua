require('mp.lib.lang').add({
    parser = {
        zig = { install = true },
    },
    tool = {
        ['zls'] = { install = vim.g.pc },
    },
    lsp = {
        zls = {},
    },
})
