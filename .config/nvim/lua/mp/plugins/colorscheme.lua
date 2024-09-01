return {
    'folke/tokyonight.nvim',
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('tokyonight').setup({
            style = 'night',
        })
        vim.cmd.colorscheme('tokyonight')
    end,
}
