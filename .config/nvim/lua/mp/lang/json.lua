require('mp.lib.lang').add({
    parser = {
        jq = { install = true },
        json = { install = true },
        json5 = { install = true },
        jsonc = { install = true },
    },
    tool = {
        ['json-lsp'] = { install = vim.g.has.npm },
    },
    lsp = {
        jsonls = {},
    },
})
