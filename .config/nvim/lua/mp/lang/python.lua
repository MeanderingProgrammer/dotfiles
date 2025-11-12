local utils = require('mp.lib.utils')

require('mp.lib.lang').add({
    parser = {
        python = { install = true },
        requirements = { install = true },
    },
    tool = {
        ['basedpyright'] = { install = vim.g.pc and vim.g.has.pip },
        ['ruff'] = { install = vim.g.pc and vim.g.has.pip },
        ['pyright'] = { install = not vim.g.pc and vim.g.has.npm },
        ['black'] = { install = not vim.g.pc and vim.g.has.pip },
        ['isort'] = { install = not vim.g.pc and vim.g.has.pip },
    },
    lsp = {
        basedpyright = {},
        pyright = {},
    },
    format = {
        ruff_fix = { cmd = 'ruff', filetypes = { 'python' } },
        ruff_format = { cmd = 'ruff', filetypes = { 'python' } },
        ruff_organize_imports = { cmd = 'ruff', filetypes = { 'python' } },
        black = { filetypes = { 'python' } },
        isort = {
            filetypes = { 'python' },
            override = { prepend_args = { '--profile', 'black' } },
        },
    },
    lint = {
        ruff = {
            filetypes = { 'python' },
            override = function(linter)
                local output = utils.system({ 'python', '--version' })
                local version = vim.version.parse(output)
                assert(version, 'unable to parse python version')
                assert(version.major == 3, 'must be using python3')
                local edition = math.max(version.minor, 7)
                linter.args = vim.list_extend(linter.args, {
                    ('--target-version=py3%d'):format(edition),
                })
            end,
        },
    },
})
