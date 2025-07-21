return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        branch = "main",
        build = {
            function()
                local parser_installed = {
                    "c",
                    "cpp",
                    "cmake",
                    "dockerfile",
                    "bash",
                    "asm",
                    "beancount",
                    "gnuplot",
                    "hyprlang",
                    "json",
                    "lua",
                    "make",
                    "markdown",
                    "markdown_inline",
                    "objdump",
                    "python",
                    "regex",
                    "rust",
                    "gitignore",
                    "ssh_config",
                    "yaml",
                    "glsl",
                    "regex",
                }
                require("nvim-treesitter").install(parser_installed)
                require("nvim-treesitter").update()
            end,
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local filetype = args.match
                    local lang = vim.treesitter.language.get_lang(filetype)
                    if vim.treesitter.language.add(lang) then
                        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                        vim.treesitter.start()
                    end
                end
            })
        end,
    }
}
