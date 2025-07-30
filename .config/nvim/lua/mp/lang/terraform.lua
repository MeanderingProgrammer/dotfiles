require('mp.lang').add({
    parser = {
        terraform = { install = true },
    },
    tool = {
        ['terraform-ls'] = { install = vim.g.pc },
        ['tflint'] = { install = vim.g.pc },
    },
    lsp = {
        terraformls = {},
    },
    lint = {
        tflint = { filetypes = { 'terraform' } },
    },
})
