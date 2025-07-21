--- @type vim.lsp.Config
return {
	cmd = {
		"clangd",
        "-j=10",
		"--background-index",
		"--pch-storage=memory",
		"--header-insertion=never",
		"--fallback-style=llvm",
		"--completion-style=detailed",
		"--limit-results=50",
		"--enable-config",
		"--experimental-modules-support",
	},
	filetypes = { "cpp", "h", "hpp", "cc", "c", "cppm" },
	root_markers = { ".git", ".clangd", "compile-commands.json" },
}
