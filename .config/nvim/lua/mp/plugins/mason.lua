local lang = require('mp.lib.lang')

return {
    'mason-org/mason.nvim',
    dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    config = function()
        local install = lang.tools()

        require('mason').setup({})

        require('mason-tool-installer').setup({
            ensure_installed = install,
        })
    end,
}
