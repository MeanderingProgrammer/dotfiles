return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-mini/mini.nvim' },
    config = function()
        require('mp.configs.lualine')
    end,
}
