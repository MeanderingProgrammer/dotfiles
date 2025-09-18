require('mp.lib.lang').add({
    parser = {
        bash = { install = true },
    },
    tool = {
        ['bash-language-server'] = { install = vim.g.has.npm },
        ['shellcheck'] = { install = vim.g.pc },
    },
    lsp = {
        bashls = {
            filetypes = { 'bash', 'sh', 'zsh' },
        },
    },
    lint = {
        shellcheck = { filetypes = { 'bash', 'sh', 'zsh' } },
    },
})
