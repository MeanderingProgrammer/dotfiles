require('mp.lib.langs').add({
    parser = {
        java = { install = true },
        javadoc = { install = true },
    },
    tool = {
        jdtls = { install = vim.g.personal },
    },
    lsp = {
        jdtls = { cmd = 'jdtls' },
    },
})
