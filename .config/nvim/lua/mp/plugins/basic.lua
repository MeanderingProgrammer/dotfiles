return {
    { 'tpope/vim-fugitive' },
    { 'j-hui/fidget.nvim', enabled = not require('mp.utils').is_termux, config = true },
}
