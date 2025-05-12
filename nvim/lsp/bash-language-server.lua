--- @type vim.lsp.Config
return {
    cmd = {"bash-language-server", "start"},
    filetypes = {"bash", "sh"},
    settings = {
        bashIde = {
            shellcheckPath = ""
        }
    }
}
