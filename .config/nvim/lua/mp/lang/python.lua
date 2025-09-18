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
        basedpyright = {
            settings = {
                basedpyright = {
                    analysis = {
                        diagnosticMode = 'workspace',
                        diagnosticSeverityOverrides = {
                            reportAny = false,
                            reportExplicitAny = false,
                            reportMissingTypeStubs = false,
                            reportUnusedCallResult = false,
                        },
                    },
                },
            },
        },
        pyright = {
            settings = {
                python = {
                    analysis = {
                        diagnosticMode = 'workspace',
                    },
                },
            },
        },
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
        ruff = { filetypes = { 'python' } },
    },
})
