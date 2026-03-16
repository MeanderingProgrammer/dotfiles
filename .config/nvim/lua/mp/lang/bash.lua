require('mp.lib.lang').add({
    parser = {
        bash = { install = true },
        zsh = { install = true },
    },
    tool = {
        ['bash-language-server'] = { install = vim.g.has.npm },
        ['shellcheck'] = { install = vim.g.pc },
    },
    lsp = {
        bashls = {},
    },
    lint = {
        shellcheck = { filetypes = { 'bash', 'sh', 'zsh' } },
    },
})
