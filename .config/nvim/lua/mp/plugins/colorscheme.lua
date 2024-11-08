return {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('tokyonight').setup({
            style = 'night',
        })
        vim.cmd.colorscheme('tokyonight')
    end,
}
