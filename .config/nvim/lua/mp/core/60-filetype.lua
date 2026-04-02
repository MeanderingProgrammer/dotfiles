vim.filetype.add({
    extension = {
        json = 'jsonc',
    },
    pattern = {
        ['.*/Brewfile.*'] = 'ruby',
        ['.*/git/config.*'] = 'gitconfig',
    },
})
