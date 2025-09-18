require('mp.lib.lang').add({
    parser = {
        c = { install = true },
        c_sharp = { install = true },
        cmake = { install = true },
        cpp = { install = true },
        make = { install = true },
    },
    tool = {
        ['clangd'] = { install = vim.g.pc },
        ['csharp-language-server'] = { install = vim.g.has.dotnet },
    },
    lsp = {
        clangd = {},
        csharp_ls = {},
    },
})
