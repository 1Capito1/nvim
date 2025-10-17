local opts = vim.opt

opts.clipboard = "unnamedplus"

opts.relativenumber = true
opts.number = true
opts.expandtab = true
opts.tabstop = 4
opts.shiftwidth = 4
opts.cursorline = true
opts.colorcolumn = "120"
opts.signcolumn = "yes"
opts.scrolloff = 999
opts.termguicolors = true

opts.undofile = true

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = signs.Error,
			[vim.diagnostic.severity.WARN] = signs.Warn,
			[vim.diagnostic.severity.HINT] = signs.Hint,
			[vim.diagnostic.severity.INFO] = signs.Info,
		},
	},
})

vim.cmd.colorscheme("kanagawa-paper-ink")
