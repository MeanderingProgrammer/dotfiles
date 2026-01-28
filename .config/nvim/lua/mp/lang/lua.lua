local utils = require('mp.lib.utils')

require('mp.lib.lang').add({
    parser = {
        lua = { install = true },
        luadoc = { install = true },
    },
    tool = {
        ['lua-language-server'] = { install = vim.g.pc, version = '3.16.4' },
        ['selene'] = { install = vim.g.pc },
        ['stylua'] = { install = vim.g.pc },
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
