return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {}, -- for default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	keys = {
		{ "<leader>cx", "<cmd>Trouble diagnostics toggle focus=true<CR>", desc = "Open/close trouble list" },
		{
			"<leader>cX",
			"<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
			desc = "Open/close trouble for buffer list",
		},
		{ "<leader>cq", "<cmd>Trouble qflist toggle focus=true<CR>", desc = "Open trouble quickfix list" },
		{ "<leader>cl", "<cmd>Trouble loclist toggle focus=true<CR>", desc = "Open trouble location list" },
	},
}
