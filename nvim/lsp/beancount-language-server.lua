--- @type vim.lsp.Config
return {
    cmd = { "beancount-language-server", "--stdio" },
    filetypes = { "beancount" },
    init_options = {
        journal_file = "~/Documents/finance/main.beancount"
    }
}
