return {
    {
        'folke/tokyonight.nvim',
        enabled = vim.g.opaque,
        priority = 1000,
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require('tokyonight').setup({
                style = 'night',
            })
            vim.cmd.colorscheme('tokyonight')
        end,
    },
    {
        'scottmckendry/cyberdream.nvim',
        enabled = not vim.g.opaque,
        priority = 1000,
        config = function()
            require('cyberdream').setup({
                transparent = true,
            })
            vim.cmd.colorscheme('cyberdream')
        end,
    },
}
