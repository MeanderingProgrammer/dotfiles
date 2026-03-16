require('mp.lib.lang').add({
    parser = {
        proto = { install = true },
    },
    tool = {
        ['clang-format'] = { install = vim.g.pc and vim.g.has.pip },
    },
    format = {
        ['clang-format'] = { filetypes = { 'proto' } },
    },
})
