---@alias mp.conform.Config table<string, mp.conform.Tool>

---@class mp.conform.Tool: mp.filetype.Tool
---@field override? conform.FormatterConfigOverride

return {
    'stevearc/conform.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    ---@type mp.conform.Config
    opts = {},
    ---@param opts mp.conform.Config
    config = function(_, opts)
        local conform = require('conform')

        local by_ft = require('mp.util').tool.by_ft(opts)

        local enabled = true

        ---@param buf integer
        ---@return boolean
        local should_format = function(buf)
            if not enabled then
                return false
            end
            local clients = require('mp.util').lsp.names(buf)
            if vim.tbl_contains(clients, 'jsonls') then
                return false
            end
            local path = vim.api.nvim_buf_get_name(buf)
            local repo = vim.fs.relpath('~/dev/repos', path)
            if not repo then
                -- outside of repos format
                return true
            else
                -- inside of repos format in specific roots
                local root = vim.split(repo, '/', { plain = true })[1]
                return vim.tbl_contains({ 'personal' }, root)
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
        for name, tool in pairs(opts) do
            if tool.override then
                conform.formatters[name] = tool.override
            end
        end

        vim.api.nvim_create_user_command('Format', function()
            conform.format(format_opts)
        end, {})

        vim.keymap.set('n', '<leader>F', function()
            enabled = not enabled
        end, { desc = 'format toggle' })
    end,
}
