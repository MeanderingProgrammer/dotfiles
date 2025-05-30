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
        map('<leader>fs', fzf.live_grep, 'grep')
        map('<leader>fd', fzf.diagnostics_workspace, 'diagnostics')
        map('<leader>fr', fzf.resume, 'resume')
        map('<leader>?', fzf.oldfiles, 'recently opened files')
        map('<leader>fb', fzf.buffers, 'existing buffers')
        map('<leader>fg', fzf.git_files, 'git files')
        map('<leader>fw', fzf.grep_cword, 'current word')
        map('<leader>ft', fzf.helptags, 'help tags')
        map('<leader>fk', fzf.keymaps, 'keymaps')
        map('<leader>fh', fzf.highlights, 'highlights')

        vim.env.YADM_REPO = vim.env.XDG_DATA_HOME .. '/yadm/repo.git'
        map('<leader>yf', function()
            fzf.git_files({
                cwd = '~',
                git_dir = vim.env.YADM_REPO,
            })
        end, 'files')
        map('<leader>yg', function()
            fzf.live_grep({
                cwd = '~',
                cmd = 'git --git-dir=${YADM_REPO} grep -i --line-number --column --color=always',
            })
        end, 'grep')
    end,
}
