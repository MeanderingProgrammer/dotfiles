local lang = require('mp.lib.lang')

return {
    'mason-org/mason.nvim',
    dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    config = function()
        local configs = lang.tools()
        local names = lang.install(configs)

        require('mason').setup({})

        require('mason-tool-installer').setup({
            ensure_installed = names,
        })
    end,
}
