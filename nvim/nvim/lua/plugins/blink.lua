return {

	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
			-- "crispgm/cmp-beancount",
			{
				"saghen/blink.compat",
				-- use the latest release, via version = '*', if you also use the latest release for blink.cmp
				version = "*",
				-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
				lazy = true,
				-- make sure to set opts so that lazy.nvim calls blink.compat's setup
				opts = {
					impersonate_nvim_cmp = true,
					enable_events = true,
					debug = true,
				},
			},
		},

		-- use a release tag to download pre-built binaries
		version = "*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "enter" },
			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "rounded" } },
				menu = { border = "rounded" },
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lazydev", "lsp", "beancount", "path", "snippets", "buffer" },
				-- default = { "beancount" },
				providers = {
					beancount = {
						name = "beancount",
                        module = 'beancount',
                        opts = {
                            account = "/home/oldest/Documents/finance/main.beancount"
                        },
					},
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
			fuzzy = {
				implementation = "prefer_rust_with_warning",
				sorts = {
					"exact",
					-- defaults
					"score",
					"sort_text",
				},
			},

			cmdline = {
				enabled = false,
			},

			signature = { enabled = true, window = { border = "rounded" } },
		},
		opts_extend = { "sources.default" },
	},
}
