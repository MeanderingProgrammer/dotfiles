local utils = require('mp.lib.utils')

---@type vim.lsp.Config
return {
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
    settings = {},
    exit_timeout = 5000,
}
