require('mp.lib.lang').add({
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
