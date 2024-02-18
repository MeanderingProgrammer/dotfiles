return {
    'Shatur/neovim-session-manager',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local config = require('session_manager.config')
        local manager = require('session_manager')
        manager.setup({ autoload_mode = config.AutoloadMode.Disabled })

        require('which-key').register({
            ['<leader>s'] = {
                name = 'session',
                d = { manager.load_current_dir_session, 'Load Directory' },
            },
        })
    end,
}
