local utils = require('mp.lib.utils')

require('lazydev').setup({
    library = { '${3rd}/luv/library' },
    enabled = function()
        return not utils.in_root('.luarc.json')
    end,
})
