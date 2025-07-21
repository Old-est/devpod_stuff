--- @type vim.lsp.Config
return {
    cmd = {'taplo', 'lsp', 'stdio'},
    filetypes = {"toml", "serenity"},
    root_markers = {"."}
}
