local ok, _ = pcall(vim.cmd, "colorscheme tokyonight-moon")
if not ok then
	print "Failed to set colorscheme"
	vim.cmd "colorscheme default"
end
