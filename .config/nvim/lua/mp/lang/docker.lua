require('mp.lib.langs').add({
    parser = {
        dockerfile = { install = true },
    },
    tool = {
        hadolint = { install = vim.g.pc },
    },
    lint = {
        hadolint = { filetypes = { 'dockerfile' } },
    },
})
