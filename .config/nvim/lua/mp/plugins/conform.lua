---@alias mp.conform.Config table<string, mp.conform.Tool>

---@class mp.conform.Tool: mp.Tool
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

        ---@type conform.FormatOpts
        local format = { lsp_format = 'fallback' }

        ---@param buf integer
        ---@return boolean
        local auto_format = function(buf)
            local clients = require('mp.util').lsp.names(buf)
            if vim.tbl_contains(clients, 'jsonls') then
                return false
            end
            -- outside of repos we should always auto format
            -- inside of repos only auto format personal repos
            local path = vim.api.nvim_buf_get_name(buf)
            local repo = vim.fs.relpath('~/dev/repos', path)
            return not repo or vim.startswith(repo, 'personal')
        end

        conform.setup({
            formatters_by_ft = by_ft,
            format_after_save = function(buf)
                return auto_format(buf) and format or nil
            end,
        })
        for name, tool in pairs(opts) do
            if tool.override then
                conform.formatters[name] = tool.override
            end
        end

        vim.api.nvim_create_user_command('Format', function()
            conform.format(format)
        end, {})
    end,
}
