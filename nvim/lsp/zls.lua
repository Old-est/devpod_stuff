--- @type vim.lsp.Config
return {
    cmd = { "zls" },
    filetypes = { "zig", "zom" },
    root_markers = { '.git' },
    settings = {
        zls = {
            semantic_tokes = "partial",
            zig_exe_path = "/usr/bin/zig",
        }
    }
}
