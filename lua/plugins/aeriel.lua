return {
	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},

		config = function()
			require("aerial").setup({
				on_attach = function(bufnr)
					vim.keymap.set("n", "<leader>[", "<CMD>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "<leader>]", "<CMD>AerialNext<CR>", { buffer = bufnr })
				end,
			})
		end,

		keys = {
			{ "<leader>a", "<CMD>AerialToggle!<CR>" },
		},
	},
}
