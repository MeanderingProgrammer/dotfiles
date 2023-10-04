return {
    'ellisonleao/glow.nvim',
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('glow').setup({
            width = 120,
        })
    end,
}
