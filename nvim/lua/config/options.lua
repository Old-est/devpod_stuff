vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.scrolloff = 8
vim.opt.swapfile = false

vim.opt.termguicolors = true

-- Включаем использование Tree-sitter для фолдинга

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99
vim.opt.smoothscroll = true

vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')

vim.g.python3_host_prog = '/home/oldest/Stuff/nvim-stuff/bin/python3'
