return {
	{

		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		config = function(_, opts)
			if opts then
				require("luasnip").config.setup(opts)
			end
			vim.tbl_map(function(type)
				require("luasnip.loaders.from_" .. type).lazy_load()
			end, { "vscode", "snipmate", "lua" })
			-- friendly-snippets - enable standardized comments snippets
			require("luasnip").filetype_extend("lua", { "luadoc" })
			require("luasnip").filetype_extend("python", { "pydoc" })
			require("luasnip").filetype_extend("rust", { "rustdoc" })
			require("luasnip").filetype_extend("c", { "cdoc" })
			require("luasnip").filetype_extend("cpp", { "cppdoc" })
			require("luasnip").filetype_extend("sh", { "shelldoc" })
		end,
	},
	{
		"saghen/blink.cmp",
		-- lazy = false, -- lazy loading handled internally
		event = "VeryLazy",
		-- optional: provides snippets for the snippet source
		version = "1.*",
		dependencies = {},
		-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- On musl libc based systems you need to add this flag
		-- build = 'RUSTFLAGS="-C target-feature=-crt-static" cargo build --release',
		opts = {
			-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- adjusts spacing to ensure icons are aligned
			snippets = { preset = "luasnip" },
			completion = {
				menu = {
					winblend = vim.o.pumblend,
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind" },
						},
						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
					},
					border = "rounded",
				},
				-- accept = {
				--     auto_brackets = {
				--         enabled = true,
				--     },
				-- },
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = { border = "rounded" },
				},
				list = {
					selection = { preselect = false, auto_insert = false },
				},
				trigger = { show_in_snippet = true},
				ghost_text = { enabled = true },
			},
			keymap = {
				preset = "enter",
			},
			appearance = {
				nerd_font_variant = "normal",
				kind_icons = {
					Array = " ",
					Boolean = "󰨙 ",
					Class = " ",
					Codeium = "󰘦 ",
					Color = " ",
					Control = " ",
					Collapsed = " ",
					Constant = "󰏿 ",
					Constructor = " ",
					Copilot = " ",
					Enum = " ",
					EnumMember = " ",
					Event = " ",
					Field = " ",
					File = " ",
					Folder = " ",
					Function = "󰊕 ",
					Interface = " ",
					Key = " ",
					Keyword = " ",
					Method = "󰊕 ",
					Module = " ",
					Namespace = "󰦮 ",
					Null = " ",
					Number = "󰎠 ",
					Object = " ",
					Operator = " ",
					Package = " ",
					Property = " ",
					Reference = " ",
					Snippet = " ",
					String = " ",
					Struct = "󰆼 ",
					TabNine = "󰏚 ",
					Text = " ",
					TypeParameter = " ",
					Unit = " ",
					Value = " ",
					Variable = "󰀫 ",
				},
			},
			cmdline = { enabled = false },

			fuzzy = {
				implementation = "prefer_rust_with_warning",
				sorts = {
					"exact",
					-- defaults
					"score",
					"sort_text",
				},
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					beancount = { "beancount", "lsp", "snippets" },
					lua = { inherit_defaults = true, "lazydev" },
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
					beancount = {
						name = "beancount",
						module = "sources.beancount",
						opts = {
							account = "/home/oldest/Documents/finance/main.beancount",
						},
					},
				},
			},
			-- experimental auto-brackets support
			-- accept = { auto_brackets = { enabled = true } }

			signature = { enabled = true, window = { border = "rounded" } },
		},
		opts_extend = { "sources.default" },
	},
}
