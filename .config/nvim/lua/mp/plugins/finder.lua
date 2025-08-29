local Keymap = require('mp.keymap')

return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-mini/mini.nvim' },
    config = function()
        local fzf = require('fzf-lua')
        local actions = require('fzf-lua.actions')
        fzf.setup({
            -- most keymaps come from fzf: https://github.com/junegunn/fzf
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
            grep = {
                hidden = true,
            },
            lsp = {
                jump1 = false,
                includeDeclaration = false,
            },
        })

        Keymap.new({ prefix = '<leader>' })
            :n('<leader>', fzf.files, 'files')
            :n('?', fzf.oldfiles, 'opened files')
            :n('g', fzf.live_grep, 'grep')
            :n('fb', fzf.buffers, 'existing buffers')
            :n('fd', fzf.diagnostics_workspace, 'diagnostics workspace')
            :n('fD', fzf.diagnostics_document, 'diagnostics document')
            :n('ff', fzf.git_files, 'git files')
            :n('fh', fzf.highlights, 'highlights')
            :n('fk', fzf.keymaps, 'keymaps')
            :n('fr', fzf.resume, 'resume')
            :n('ft', fzf.helptags, 'help tags')
            :n('fw', fzf.grep_cword, 'current word')

        local yadm = vim.fs.joinpath(vim.env.XDG_DATA_HOME, 'yadm', 'repo.git')
        Keymap.new({ prefix = '<leader>y' })
            :n('f', function()
                fzf.git_files({ cwd = '~', git_dir = yadm })
            end, 'files')
            :n('g', function()
                local cmd = ('git --git-dir=%s grep -i'):format(yadm)
                fzf.live_grep({ cwd = '~', cmd = cmd, hidden = false })
            end, 'grep')
    end,
}
