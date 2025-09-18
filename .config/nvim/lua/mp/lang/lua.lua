local utils = require('mp.lib.utils')

require('mp.lib.lang').add({
    parser = {
        lua = { install = true },
        luadoc = { install = true },
    },
    tool = {
        ['lua-language-server'] = { install = vim.g.pc },
        ['selene'] = { install = vim.g.pc },
        ['stylua'] = { install = vim.g.pc },
    },
    lsp = {
        lua_ls = {
            settings = {
                Lua = {
                    hint = { enable = true },
                    runtime = { version = 'LuaJIT' },
                    diagnostics = {
                        ignoredFiles = 'Enable',
                        groupFileStatus = {
                            ['await'] = 'Any',
                            ['duplicate'] = 'Any',
                            ['luadoc'] = 'Any',
                            ['redefined'] = 'Any',
                            ['strong'] = 'Any',
                            ['type-check'] = 'Any',
                            ['unused'] = 'Any',
                        },
                    },
                },
            },
        },
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
