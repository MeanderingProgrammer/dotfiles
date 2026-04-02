require('mp.lib.langs').add({
    parser = {
        jq = { install = true },
        json = { install = true },
        json5 = { install = true },
    },
    tool = {
        ['json-lsp'] = { install = vim.g.has.npm },
    },
    lsp = {
        jsonls = {},
    },
})
