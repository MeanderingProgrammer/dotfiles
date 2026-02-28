require('mp.lib.lang').add({
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
