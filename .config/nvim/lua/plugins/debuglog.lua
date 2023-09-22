return {
    'smartpde/debuglog',
    config = function()
        local debuglog = require('debuglog')
        debuglog.setup({
            log_to_console = false,
            log_to_file = true,
        })
        debuglog.enable('*')
    end,
}
