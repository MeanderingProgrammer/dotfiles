return {
    'Shatur/neovim-session-manager',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local config = require('session_manager.config')
        require('session_manager').setup({
            autoload_mode = config.AutoloadMode.CurrentDir,
        })
    end,
}
