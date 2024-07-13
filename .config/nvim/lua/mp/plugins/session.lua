return {
    'Shatur/neovim-session-manager',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local manager = require('session_manager')
        local config = require('session_manager.config')
        manager.setup({ autoload_mode = config.AutoloadMode.Disabled })

        vim.keymap.set('n', '<leader>sd', manager.load_current_dir_session, { desc = 'Load Directory' })
    end,
}
