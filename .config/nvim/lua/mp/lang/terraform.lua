require('mp.lib.langs').add({
    parser = {
        terraform = { install = true },
    },
    tool = {
        ['terraform-ls'] = { install = vim.g.pc },
        ['tflint'] = { install = vim.g.pc },
    },
    lsp = {
        terraformls = { cmd = 'terraform-ls' },
    },
    lint = {
        tflint = { filetypes = { 'terraform' } },
    },
})
