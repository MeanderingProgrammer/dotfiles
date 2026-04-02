require('mp.lib.langs').add({
    parser = {
        diff = { install = true },
        git_config = { install = true },
        gitattributes = { install = true },
        gitcommit = { install = not vim.g.wsl },
        gitignore = { install = true },
    },
})
