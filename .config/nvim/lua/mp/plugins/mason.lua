local utils = require('mp.utils')

return {
    'williamboman/mason.nvim',
    dependencies = {
        'mfussenegger/nvim-lint',
        'stevearc/conform.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    opts = {
        formatters = {},
        linters = {},
        linter_overrides = {},
    },
    config = function(_, opts)
        require('mason').setup({})

        ---@type table<string, boolean>
        local all_commands = {}
        ---@type table<string, boolean>
        local ensure_installed = {}

        ---@param values table<string, string[]>
        ---@return table<string, string[]>
        local function filter_packages(values)
            local result = {}
            local mason = { 'black', 'goimports', 'gofumpt', 'isort', 'markdownlint' }
            local system = { 'stylua' }
            for name, commands in pairs(values) do
                commands = vim.iter(commands)
                    :filter(function(command)
                        if not utils.is_android or vim.tbl_contains(mason, command) then
                            all_commands[command] = true
                            ensure_installed[command] = true
                            return true
                        elseif vim.tbl_contains(system, command) then
                            all_commands[command] = true
                            return true
                        else
                            return false
                        end
                    end)
                    :totable()
                if #commands > 0 then
                    result[name] = commands
                end
            end
            return result
        end

        local formatters = filter_packages(opts.formatters)
        local linters = filter_packages(opts.linters)

        require('mason-tool-installer').setup({
            ensure_installed = vim.tbl_keys(ensure_installed),
        })

        require('conform').setup({
            formatters_by_ft = formatters,
            format_after_save = function(bufnr)
                local name = vim.api.nvim_buf_get_name(bufnr)
                local disabled_name = name:find('/open-source/', 1, true)
                if disabled_name ~= nil then
                    return nil
                end
                return { lsp_format = 'fallback' }
            end,
        })

        local lint = require('lint')
        lint.linters_by_ft = linters
        for name, override in pairs(opts.linter_overrides) do
            if all_commands[name] then
                lint.linters[name] = override(lint.linters[name])
            end
        end

        local events = { 'BufRead', 'BufWritePost', 'InsertLeave' }
        vim.api.nvim_create_autocmd(events, {
            group = vim.api.nvim_create_augroup('NvimLint', { clear = true }),
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
