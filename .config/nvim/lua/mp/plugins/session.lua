return {
    'Shatur/neovim-session-manager',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local config = require('session_manager.config')
        local manager = require('session_manager')
        manager.setup({ autoload_mode = config.AutoloadMode.Disabled })
        vim.keymap.set('n', '<leader>sd', manager.load_current_dir_session, { desc = 'Session: Load Directory' })
    end,
}
