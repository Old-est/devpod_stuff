return {
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"clangd",
                "beancount",
                "basedpyright",
                "ruff",
                "neocmake",
                "bashls"
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"stylua",
                "mypy",
                "prettier",
                "cmakelint",
                "shfmt",
			},
		},
	},
}
