return {
    'ibhagwan/fzf-lua',
    dependencies = { 'echasnovski/mini.nvim' },
    config = function()
        -- TODO: should I use utils.hidden_directories() for files action

        local fzf = require('fzf-lua')
        local actions = require('fzf-lua.actions')
        fzf.setup({
            -- Note: most keymaps come from fzf: https://github.com/junegunn/fzf
            actions = {
                files = {
                    ['enter'] = actions.file_switch_or_edit,
                    ['ctrl-v'] = actions.file_vsplit,
                    ['ctrl-x'] = actions.file_split,
                    ['ctrl-t'] = actions.file_tabedit,
                },
            },
            fzf_opts = {
                ['--cycle'] = true,
            },
            defaults = {
                file_icons = 'mini',
                formatter = 'path.filename_first',
            },
            lsp = {
                jump1 = false,
                includeDeclaration = false,
            },
        })

        ---@param lhs string
        ---@param rhs string|function
        ---@param desc string
        local function map(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { desc = desc })
        end
        map('<leader><leader>', fzf.files, 'Find Files')
        map('<leader>fs', fzf.live_grep, 'Grep Files')
        map('<leader>fd', fzf.diagnostics_workspace, 'Diagnostics')
        map('<leader>fr', fzf.resume, 'Resume')
        map('<leader>?', fzf.oldfiles, 'Find Recently Opened Files')
        map('<leader>fb', fzf.buffers, 'Find Existing Buffers')
        map('<leader>fg', fzf.git_files, 'Git Files')
        map('<leader>fw', fzf.grep_cword, 'Current Word')
        map('<leader>ft', fzf.helptags, 'Help Tags')
        map('<leader>fk', fzf.keymaps, 'Keymaps')
        map('<leader>fh', fzf.highlights, 'Highlights')
    end,
}
