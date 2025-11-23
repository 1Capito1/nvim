return {
	{ "neovim/nvim-lspconfig" },

	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			automatic_enable = {
				exclude = { "clangd" },
			},
			ensure_installed = { "clangd" },
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--compile-commands-dir=build",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
				},
				root_markers = { "compiler_commands.json", ".git" },
			})
			vim.lsp.enable("clangd")
		end,
	},
}
