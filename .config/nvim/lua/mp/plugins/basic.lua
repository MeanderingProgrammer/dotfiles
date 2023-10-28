local icons = 'nvim-tree/nvim-web-devicons'

return {
    { 'mg979/vim-visual-multi' },
    { 'numToStr/Comment.nvim', config = true },
    { 'nvim-lualine/lualine.nvim', dependencies = { icons }, config = true },
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-sleuth' },
}
