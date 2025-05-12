-- pretty diagnostics, references, telescope results, quickfix and location list
-- to help you solve allow the trouble your code is causing

local spec = { "folke/trouble.nvim" }

function spec.config()
    require("trouble").setup {
        focus = true,
        padding = false,
        use_diagnostic_signs = true,
        modes = {
            symbols = {
                format = "{kind_icon} {symbol.name}",
            },
            lsp_document_symbols = {
                format = "{kind_icon} {symbol.name}",
            }
        }
    }

    -- when LS attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('TroubleLspAttach', {}),
        callback = function(_ev)
            vim.keymap.set('n', 'cx', "<cmd>Trouble diagnostics toggle focus=true<CR>",
                { desc = "Open/close trouble list" })
            vim.keymap.set('n', 'cX', "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
                { desc = "Open/close trouble for buffer list" })
            vim.keymap.set('n', 'cq', "<cmd>Trouble qflist toggle focus=true<CR>",
                { desc = "Open trouble quickfix list" })
            vim.keymap.set('n', 'cl', "<cmd>Trouble loclist toggle focus=true<CR>",
                { desc = "Open trouble location list" })
        end,
    })
end

return spec
