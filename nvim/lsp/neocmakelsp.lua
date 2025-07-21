local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

--- @type vim.lsp.Config
return {
    cmd = { "neocmakelsp", "--stdio" },
    filetypes = { "cmake" },
    root_markers = { '.git' },
    capabilities = capabilities,
}
