return {
    'mason-org/mason.nvim',
    dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    config = function()
        require('mason').setup({})

        local install = require('mp.lang').tools()

        require('mason-tool-installer').setup({
            ensure_installed = install,
        })
    end,
}
