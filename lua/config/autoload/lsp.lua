require("mason-lspconfig").setup({
	automatic_enable = {
		exclude = {
			"jdtls",
			"rust-analyzer",
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
