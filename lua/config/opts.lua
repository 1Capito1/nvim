local opts = vim.opt


opts.clipboard = "unnamedplus"

opts.relativenumber = true
opts.expandtab = true
opts.tabstop = 4
opts.shiftwidth = 4
opts.cursorline = true
opts.colorcolumn = "120"
opts.signcolumn = "yes"

vim.fn.undofile = true

opts.undofile = true

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.cmd.colorscheme("kanagawa-paper-ink")
