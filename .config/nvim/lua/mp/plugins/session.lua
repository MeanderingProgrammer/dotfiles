return {
    'Shatur/neovim-session-manager',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local config = require('session_manager.config')
        local manager = require('session_manager')
        manager.setup({ autoload_mode = config.AutoloadMode.Disabled })

        local map = require('mp.config.utils').leader_map
        map('sd', manager.load_current_dir_session, 'Session: Load Directory')
    end,
}
