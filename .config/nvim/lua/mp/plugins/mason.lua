return {
    'mason-org/mason.nvim',
    dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    config = function()
        require('mp.configs.mason')
    end,
}
