require('mp.lib.lang').add({
    parser = {
        go = { install = true },
        gomod = { install = true },
        gosum = { install = true },
        gowork = { install = true },
    },
    tool = {
        ['gopls'] = { install = vim.g.has.go },
        ['gofumpt'] = { install = vim.g.has.go },
        ['goimports'] = { install = vim.g.has.go },
    },
    lsp = {
        gopls = {},
    },
    format = {
        gofumpt = { filetypes = { 'go' } },
        goimports = { filetypes = { 'go' } },
    },
})
