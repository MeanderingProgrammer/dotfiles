local utils = require('mp.lib.utils')

---@type vim.lsp.Config
return {
    root_markers = vim.list_extend(
        { 'ty.toml', 'uv.lock' },
        utils.python_root_markers
    ),
    settings = {},
    before_init = function(_, config)
        local version = utils.python_version('.')
        config.settings.ty = {
            configuration = {
                environment = {
                    ['python-version'] = version,
                },
            },
        }
    end,
    exit_timeout = 5000,
}
