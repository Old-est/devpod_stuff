return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix",
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		spec = {
			mode = { "n", "v" },
			{ "<leader>f", group = "Find" },
			{ "<leader>s", group = "Search" },
			{ "<leader>c", group = "Coding" },
			{ "<leader>g", group = "Git" },
			{ "<leader>l", group = "LSP" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
