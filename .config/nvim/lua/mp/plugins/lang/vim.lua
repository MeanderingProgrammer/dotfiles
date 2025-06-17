return {
    {
        'nvim-treesitter/nvim-treesitter',
        ---@type mp.ts.Config
        opts = {
            query = { install = true },
            vim = { install = true },
            vimdoc = { install = true },
        },
    },
}
