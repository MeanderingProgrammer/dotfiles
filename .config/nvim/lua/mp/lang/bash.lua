require('mp.lib.lang').add({
    parser = {
        bash = { install = true, filetypes = { 'zsh' } },
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
