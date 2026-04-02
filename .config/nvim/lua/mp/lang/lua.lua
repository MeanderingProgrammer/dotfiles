local utils = require('mp.lib.utils')

require('mp.lib.langs').add({
    parser = {
        lua = { install = true },
        luadoc = { install = true },
    },
    tool = {
        ['lua-language-server'] = {
            install = vim.g.pc and vim.g.personal,
            version = '3.16.4',
        },
        ['selene'] = { install = vim.g.pc and vim.g.personal },
        ['stylua'] = { install = vim.g.pc and vim.g.personal },
    },
    lsp = {
        lua_ls = {},
    },
    format = {
        stylua = { filetypes = { 'lua' } },
    },
    lint = {
        selene = {
            filetypes = { 'lua' },
            condition = function()
                return utils.in_root('selene.toml')
            end,
        },
    },
})
