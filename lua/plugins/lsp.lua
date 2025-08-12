return {
	{"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end
	},
	{"williamboman/mason-lspconfig.nvim", config = true},
	{ "neovim/nvim-lspconfig" },
}
