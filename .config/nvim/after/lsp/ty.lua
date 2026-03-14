local utils = require('mp.lib.utils')

---@type vim.lsp.Config
return {
    before_init = function(_, config)
        local version = utils.python()
        local target = ('%d.%d'):format(version.major, version.minor)
        config.settings.ty = {
            configuration = {
                environment = {
                    ['python-version'] = target,
                },
            },
        }
    end,
    settings = {},
}
