local utils = require('mp.lib.utils')

require('mp.lib.langs').add({
    parser = {
        python = { install = true },
        requirements = { install = true },
    },
    tool = {
        basedpyright = {
            install = vim.g.pc and vim.g.personal and vim.g.has.pip,
        },
        ty = {
            install = vim.g.pc and not vim.g.personal and vim.g.has.pip,
        },
        ruff = { install = vim.g.pc and vim.g.has.pip },
        pyright = { install = not vim.g.pc and vim.g.has.npm },
        black = { install = not vim.g.pc and vim.g.has.pip },
        isort = { install = not vim.g.pc and vim.g.has.pip },
    },
    lsp = {
        basedpyright = { cmd = 'basedpyright-langserver' },
        pyright = { cmd = 'pyright-langserver' },
        ty = { cmd = 'ty' },
    },
    format = {
        ruff_fix = { cmd = 'ruff', filetypes = { 'python' } },
        ruff_format = { cmd = 'ruff', filetypes = { 'python' } },
        ruff_organize_imports = { cmd = 'ruff', filetypes = { 'python' } },
        black = { filetypes = { 'python' }, fallback = true },
        isort = {
            filetypes = { 'python' },
            fallback = true,
            override = { prepend_args = { '--profile', 'black' } },
        },
    },
    lint = {
        ruff = {
            filetypes = { 'python' },
            args = function()
                local version = utils.python_version('')
                ---@type string[]
                return { ('--target-version=py%s'):format(version) }
            end,
        },
    },
})
