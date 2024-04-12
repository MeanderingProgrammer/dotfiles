return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local oil = require('oil')
        oil.setup({
            view_options = {
                show_hidden = true,
            },
        })
        local function toggle_oil()
            oil.toggle_float(vim.fn.getcwd())
        end
        require('which-key').register({
            ['<leader>o'] = {
                name = 'oil',
                t = { toggle_oil, 'Toggle' },
            },
        })
    end,
}
