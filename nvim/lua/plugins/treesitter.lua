return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		ensure_installed = {
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
		},
		highlight = {
			enable = true,
		},
		textobjects = {
			select = {
				enable = false,
			},
		},
		indent = { enable = true },
	},

	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}   
