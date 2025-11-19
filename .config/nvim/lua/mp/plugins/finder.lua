local Keymap = require('mp.lib.keymap')
local utils = require('mp.lib.utils')

return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-mini/mini.nvim' },
    config = function()
        local fzf = require('fzf-lua')
        local actions = require('fzf-lua.actions')

        ---@type string[]
        local rg = {
            '--column',
            '--line-number',
            '--no-heading',
            '--color=always',
            '--smart-case',
            '--max-columns=4096',
            '--hidden',
        }
        for _, folder in ipairs(utils.hidden) do
            rg[#rg + 1] = ('--glob=!**/%s/*'):format(folder)
        end
        rg[#rg + 1] = '-e'

        fzf.setup({
            actions = {
                files = {
                    ['enter'] = actions.file_switch_or_edit,
                    ['ctrl-v'] = actions.file_vsplit,
                    ['ctrl-x'] = actions.file_split,
                    ['ctrl-t'] = actions.file_tabedit,
                    ['ctrl-q'] = {
                        fn = actions.file_sel_to_qf,
                        prefix = 'select-all',
                    },
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
                rg_opts = table.concat(rg, ' '),
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

        Keymap.new({ prefix = '<leader>f' })
            :n('b', fzf.buffers, 'existing buffers')
            :n('d', fzf.diagnostics_workspace, 'diagnostics workspace')
            :n('D', fzf.diagnostics_document, 'diagnostics document')
            :n('f', fzf.git_files, 'git files')
            :n('h', fzf.highlights, 'highlights')
            :n('k', fzf.keymaps, 'keymaps')
            :n('r', fzf.resume, 'resume')
            :n('t', fzf.helptags, 'help tags')
            :n('w', fzf.grep_cword, 'current word')

        local yadm = vim.fs.joinpath(vim.env.XDG_DATA_HOME, 'yadm', 'repo.git')
        Keymap.new({ prefix = '<leader>y' })
            :n('f', function()
                fzf.git_files({ cwd = '~', git_dir = yadm })
            end, 'files')
            :n('g', function()
                local cmd = ('git --git-dir=%s grep -i'):format(yadm)
                fzf.live_grep({ cwd = '~', cmd = cmd })
            end, 'grep')
    end,
}
