return {
    'folke/snacks.nvim',
    dependencies = { 'echasnovski/mini.nvim' },
    config = function()
        local snacks = require('snacks')
        ---@diagnostic disable-next-line: missing-fields
        snacks.setup({
            ---@diagnostic disable-next-line: missing-fields
            scratch = { ft = 'markdown' },
            words = { enabled = true },
        })

        ---@param lhs string
        ---@param rhs function
        ---@param desc string
        local function map(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { desc = desc })
        end
        map('<leader>sb', snacks.scratch.open, 'Scratch Buffer')
        map(']]', function()
            snacks.words.jump(vim.v.count1)
        end, 'Next Reference')
        map('[[', function()
            snacks.words.jump(-vim.v.count1)
        end, 'Previous Reference')
    end,
}
