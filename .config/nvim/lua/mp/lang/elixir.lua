require('mp.lib.langs').add({
    parser = {
        elixir = { install = true },
    },
    tool = {
        ['elixir-ls'] = { install = vim.g.has.elixir },
    },
    lsp = {
        elixirls = {},
    },
})
