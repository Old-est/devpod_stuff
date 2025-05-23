return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = { left = "|", right = "|" },
                section_separators = { left = "", right = "" },
                -- section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = { "snacks_dashboard" },
                },
                ignore_focus = {},
                always_divide_middle = false,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    {
                        "filetype",
                        icon_only = true,
                        padding = { left = 1, right = 0 },
                        separator = "",
                    },
                    { "filename" },
                    { "fileformat" },
                },
                lualine_c = {
                    { "branch" },
                    {
                        "diff",
                        symbols = {
                            added = " ",
                            modified = " ",
                            removed = " ",
                        },
                        source = function()
                            local gitsigns = vim.b.gitsigns_status_dict
                            if gitsigns then
                                return {
                                    added = gitsigns.added,
                                    modified = gitsigns.changed,
                                    removed = gitsigns.removed,
                                }
                            end
                        end,
                    },
                },
                lualine_x = {
                    {
                        "diagnostics",
                        symbols = {
                            error = " ",
                            warn = " ",
                            info = " ",
                            hint = " ",
                        },
                    },
                },
                lualine_y = {
                    {
                        "lsp_status",
                    },
                    {
                        function()
                            return "  " .. require("dap").status()
                        end,
                        cond = function()
                            return package.loaded["dap"] and require("dap").status() ~= ""
                        end,
                    },
                },
                lualine_z = { { "progress" }, { "location" } },
            },
        },
        config = function(_, opts)
            local lualine_require = require("lualine_require")
            lualine_require.require = require

            if vim.bo.filetype == "python" then
                local virtual_env = function()
                    local conda_env = os.getenv("CONDA_DEFAULT_ENV")
                    local venv_path = os.getenv("VIRTUAL_ENV")

                    if venv_path == nil then
                        if conda_env == nil then
                            return ""
                        else
                            return string.format("%s (conda)", conda_env)
                        end
                    else
                        local venv_name = vim.fn.fnamemodify(venv_path, ":t")
                        return string.format("%s (venv)", venv_name)
                    end
                end

                table.insert(opts.sections.lualine_b, virtual_env)
            end

            require("lualine").setup(opts)
        end,
    },
}
