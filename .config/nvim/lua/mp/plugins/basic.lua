local icons = 'nvim-tree/nvim-web-devicons'

---@param mode string
---@param prefix string
---@return table
local function load_fterm(mode, prefix)
    local command = '<cmd>lua require("FTerm").toggle()<cr>'
    return { '<A-i>', prefix .. command, mode = mode, desc = 'FTerm: Toggle' }
end

return {
    { 'j-hui/fidget.nvim', config = true },
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('ibl').setup({
                exclude = { filetypes = { 'dashboard' } },
                scope = { enabled = false },
            })
        end,
    },
    { 'mg979/vim-visual-multi' },
    { 'numToStr/Comment.nvim', config = true },
    {
        'numToStr/FTerm.nvim',
        keys = { load_fterm('n', ''), load_fterm('t', '<esc>') },
        config = true,
    },
    { 'nvim-lualine/lualine.nvim', dependencies = { icons }, config = true },
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-sleuth' },
}
