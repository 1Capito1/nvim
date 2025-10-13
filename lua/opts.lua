local opts = vim.opt

opts.clipboard = "unnamedplus"

opts.relativenumber = true
opts.expandtab = true
opts.tabstop = 4
opts.shiftwidth = 4

vim.fn.undofile = true

local undodir = vim.fn.stdpath("state") .. "/undo"
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p", "0700")
end

vim.opt.undodir = undodir

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
