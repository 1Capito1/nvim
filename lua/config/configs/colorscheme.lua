local ok, _ = pcall(vim.cmd, "colorscheme oh-lucy-evening")
if not ok then
	print "Failed to set colorscheme"
	vim.cmd "colorscheme default"
end
