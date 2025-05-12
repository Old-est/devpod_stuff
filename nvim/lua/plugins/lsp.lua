-- lsp setup

local spec = {
    "mason-org/mason.nvim",
}

function spec.config()
    require("mason").setup()
    for _, f in pairs(vim.api.nvim_get_runtime_file('lsp/*.lua', true)) do
        local name = vim.fn.fnamemodify(f, ':t:r')
        local cmd = dofile(f).cmd[1]
        if vim.fn.executable(cmd) == 0 then
            vim.cmd("MasonInstall " .. name)
        end
        vim.lsp.enable(name)

        local packages = {
            black = "black"
        }
        for cmd, pkg in pairs(packages) do
            if vim.fn.executable(cmd) == 0 then
                vim.cmd("MasonInstall " .. pkg)
            end
        end
    end

    local keymap = vim.keymap
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true, { args.buf })
            end
            local opts = { buffer = args.buf, silent = true }
            opts.desc = "See available code actions"
            keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

            opts.desc = "Smart rename"
            keymap.set("n", "<leader>lR", vim.lsp.buf.rename, opts) -- smart rename

            -- opts.desc = "Show line diagnostics"
            -- keymap.set("n", "<leader>ls", vim.diagnostic.open_float, opts) -- show diagnostics for line

            opts.desc = "Show documentation for what is under cursor"
            keymap.set("n", "<leader>lk", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        end,
    })

    -- wrappers to allow for toggling
    local def_virtual_text = {
        isTrue = {
            severity = { max = "WARN" },
            source = "if_many",
            spacing = 4,
            prefix = "● ",
        },
        isFalse = false,
    }

    local function truncate_message(message, max_length)
        if #message > max_length then
            return message:sub(1, max_length) .. "..."
        end
        return message
    end

    local def_virtual_lines = {
        isTrue = {
            current_line = true,
            severity = { min = "ERROR" },
            format = function(diagnostic)
                local max_length = 100 -- Set your preferred max length
                return "● " .. truncate_message(diagnostic.message, max_length)
            end,
        },
        isFalse = false,
    }

    local default_diagnostic_config = {
        update_in_insert = false,
        virtual_lines = def_virtual_lines.isTrue,
        virtual_text = def_virtual_text.isTrue,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
        signs = {
            text = {
                -- [vim.diagnostic.severity.ERROR] = " ",
                -- [vim.diagnostic.severity.WARN] = " ",
                -- [vim.diagnostic.severity.INFO] = " ",
                -- [vim.diagnostic.severity.HINT] = " ",
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.INFO] = "",
                [vim.diagnostic.severity.HINT] = "",
            },
            numhl = {
                [vim.diagnostic.severity.ERROR] = "ErrorMsg", -- Just cause its also bold
                [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
                [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
                [vim.diagnostic.severity.HINT] = "DiagnosticHint",
            },
        },
    }

    vim.diagnostic.config(default_diagnostic_config)
end

return spec
