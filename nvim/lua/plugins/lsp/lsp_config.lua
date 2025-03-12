return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			update_in_insert = false,
			float = {
				border = "rounded",
				source = "always", -- Показывать источник диагностики
			},
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()
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

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>lO", ":LspRestart<CR>", opts)
				-- whatever other lsp config you want
			end,
		})

		mason_lspconfig.setup_handlers({
			-- function(server_name)
			-- 	lspconfig[server_name].setup({ capabilities = capabilities })
			-- end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							hint = {
								enable = true,
								arrayIndex = "Enable",
								setType = true,
							},
						},
					},
				})
			end,
			["clangd"] = function()
				lspconfig["clangd"].setup({
					cmd = {
						"clangd",
						"--header-insertion=never",
						"--background-index",
						"--completion-style=detailed",
						"--fallback-style=llvm",
						"--inlay-hints",
					},
				})
			end,
			["beancount"] = function()
				lspconfig["beancount"].setup({
					init_options = {
						journal_file = "/home/oldest/Documents/finance/main.beancount",
					},
				})
			end,
			["basedpyright"] = function()
				lspconfig["basedpyright"].setup({
					settings = {
						python = {
							analysis = {
								typeCheckingMode = "basic", -- Используем базовую проверку типов, можно настроить на строгую
								diagnosticMode = "workspace",
							},
						},
					},
				})
			end,
			["neocmake"] = function()
				lspconfig["neocmake"].setup({})
			end,
			["bashls"] = function()
				lspconfig["bashls"].setup({
					-- settings = {
					--     bashIde = {
					--         shellcheckPath = ""
					--     }
					-- }
				})
			end,
		})
	end,
}
