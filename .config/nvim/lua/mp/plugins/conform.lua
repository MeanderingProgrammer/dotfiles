local utils = require('mp.utils')

return {
    'stevearc/conform.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    config = function()
        local conform = require('conform')

        local configs = require('mp.lang').formatters()
        local names, by_ft = require('mp.lang').by_ft(configs)

        local enabled = true

        ---@param buf integer
        ---@return boolean
        local function should_format(buf)
            if not enabled then
                return false
            end
            local clients = utils.lsp_names(buf)
            if vim.list_contains(clients, 'jsonls') then
                return false
            end
            local path = vim.api.nvim_buf_get_name(buf)
            local repo = vim.fs.relpath('~/dev/repos', path)
            if not repo then
                -- outside of repos always format
                return true
            else
                -- inside of repos format in specific roots
                local root = utils.split(repo, '/')[1]
                return vim.list_contains({ 'personal' }, root)
            end
        end

        ---@type conform.FormatOpts
        local format_opts = { lsp_format = 'fallback' }

        conform.setup({
            formatters_by_ft = by_ft,
            format_after_save = function(buf)
                return should_format(buf) and format_opts or nil
            end,
        })
        for _, name in ipairs(names) do
            local config = configs[name]
            if config.init then
                config.init()
            end
            if config.override then
                conform.formatters[name] = config.override
            end
        end

        vim.api.nvim_create_user_command('Format', function()
            conform.format(format_opts)
        end, {})

        vim.keymap.set('n', '<leader>F', function()
            enabled = not enabled
        end, { desc = 'toggle format' })
    end,
}
