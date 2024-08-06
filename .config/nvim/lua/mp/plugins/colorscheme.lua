return {
    'folke/tokyonight.nvim',
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('tokyonight').setup({
            style = 'night',
            -- TODO: Remove once merged https://github.com/folke/tokyonight.nvim/pull/620
            plugins = { markdown = true },
        })
        vim.cmd.colorscheme('tokyonight')
    end,
}
