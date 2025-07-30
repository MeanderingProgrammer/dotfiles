require('mp.lang').add({
    parser = {
        ocaml = { install = true },
    },
    tool = {
        ['ocaml-lsp'] = { install = vim.g.has.opam },
        ['ocamlformat'] = { install = vim.g.has.opam },
    },
    lsp = {
        ocamllsp = {},
    },
    format = {
        ocamlformat = { filetypes = { 'ocaml' } },
    },
})
