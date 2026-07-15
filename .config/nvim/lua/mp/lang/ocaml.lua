require('mp.lib.langs').add({
    parser = {
        ocaml = { install = true },
    },
    tool = {
        ['ocaml-lsp'] = { install = vim.g.has.opam },
        ['ocamlformat'] = { install = vim.g.has.opam },
    },
    lsp = {
        ocamllsp = { cmd = 'ocamllsp' },
    },
    format = {
        ocamlformat = { filetypes = { 'ocaml' } },
    },
})
