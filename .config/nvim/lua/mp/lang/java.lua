require('mp.lib.lang').add({
    parser = {
        java = { install = true },
        javadoc = { install = true },
    },
    tool = {
        ['jdtls'] = { install = true },
    },
    lsp = {
        jdtls = { cmd = 'jdtls' },
    },
})
