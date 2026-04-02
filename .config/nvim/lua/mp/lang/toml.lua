require('mp.lib.langs').add({
    parser = {
        toml = { install = true },
    },
    tool = {
        taplo = { install = vim.g.pc },
    },
    format = {
        taplo = { filetypes = { 'toml' } },
    },
})
