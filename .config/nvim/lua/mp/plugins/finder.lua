return {
    'ibhagwan/fzf-lua',
    dependencies = { 'echasnovski/mini.nvim' },
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

        ---@param lhs string
        ---@param rhs function
        ---@param desc string
        local function map(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { desc = desc })
        end

        map('<leader><leader>', fzf.files, 'files')
        map('<leader>?', fzf.oldfiles, 'opened files')
        map('<leader>g', fzf.live_grep, 'grep')
        map('<leader>fb', fzf.buffers, 'existing buffers')
        map('<leader>fd', fzf.diagnostics_workspace, 'diagnostics workspace')
        map('<leader>fD', fzf.diagnostics_document, 'diagnostics document')
        map('<leader>ff', fzf.git_files, 'git files')
        map('<leader>fh', fzf.highlights, 'highlights')
        map('<leader>fk', fzf.keymaps, 'keymaps')
        map('<leader>fr', fzf.resume, 'resume')
        map('<leader>ft', fzf.helptags, 'help tags')
        map('<leader>fw', fzf.grep_cword, 'current word')

        local yadm = vim.fs.joinpath(vim.env.XDG_DATA_HOME, 'yadm', 'repo.git')
        map('<leader>yf', function()
            fzf.git_files({ cwd = '~', git_dir = yadm })
        end, 'files')
        map('<leader>yg', function()
            local cmd = ('git --git-dir=%s grep -i'):format(yadm)
            fzf.live_grep({ cwd = '~', cmd = cmd, hidden = false })
        end, 'grep')
    end,
}
