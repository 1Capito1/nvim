require("mason-lspconfig").setup({
	automatic_enable = {
		exclude = {
			"jdtls",
			"rust_analyzer",
		},
	},
})

vim.lsp.inlay_hint.enable(true)

vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		require("config.jdtls.jdtls_setup").setup()
	end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = "*",
	callback = function()
		local mode = vim.api.nvim_get_mode().mode
		if mode == "n" then
			vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
		else
			vim.lsp.inlay_hint.enable(false, { bufnr = 0 })
		end
	end,
})
