local opts = vim.opt

opts.clipboard = "unnamedplus"

opts.relativenumber = true
opts.number = true
opts.expandtab = true
opts.tabstop = 4
opts.shiftwidth = 4
opts.cursorline = true
opts.signcolumn = "yes"
opts.scrolloff = 999
opts.termguicolors = true

opts.undofile = true

-- nvim-treesitter has no indents.scm for c_sharp, so its FileType autocmd
-- leaves indentexpr pointing at a query that never fires; fall back to cindent.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "cs",
	callback = function()
		vim.bo.indentexpr = ""
		vim.bo.cindent = true
	end,
})

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
