require('mp.lib.lang').add({
    parser = {
        comment = { install = true },
        just = { install = true },
        kotlin = { install = true },
        nix = { install = true },
        regex = { install = true },
        scala = { install = true },
        ssh_config = { install = true },
        yaml = { install = true },
    },
    tool = {
        ['tree-sitter-cli'] = { install = vim.g.pc },
    },
})
