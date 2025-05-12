--- @type vim.lsp.Config
return {
    cmd = { "clangd", "--background-index", "--query-driver=**", "--header-insertion=never",
        "--fallback-style=llvm",
        "--inlay-hints", },
    filetypes = { "cpp", "h", "hpp", "cc", "c" },
    root_markers = { '.git', ".clangd", "compile-commands.json" },
}
