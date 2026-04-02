return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-mini/mini.nvim' },
    config = function()
        require('mp.configs.fzf-lua')
    end,
}
