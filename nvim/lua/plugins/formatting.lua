return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 500 })
			end,
			desc = "Format file or range",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_format", "ruff_organize_imports", lsp_format = "fallback" },
            json = {"prettier"},
            yaml = {"prettier"},
            markdown = {"prettier"},
            cmake = {"cmake_format"},
            sh = {"shfmt"},
            beancount = {"bean-format"}
		},
	},
}
