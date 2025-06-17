return {
    {
        'nvim-treesitter/nvim-treesitter',
        ---@type mp.ts.Config
        opts = {
            diff = { install = true },
            gitcommit = { install = true },
            gitignore = { install = true },
        },
    },
}
