return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	lazy = false,
	opts = {},
	config = function()
		require("refactoring").setup({})
	end,
	keys = {
		{
			"<leader>rf",
			function()
				return require("refactoring").refactor("Extract Function To File")
			end,
			mode = { "n", "x" },
			expr = true,
			desc = "Extract function to file",
		},
		{
			"<leader>rv",
			function()
				return require("refactoring").refactor("Extract Variable")
			end,
			mode = { "n", "x" },
			expr = true,
			desc = "Extract variable",
		},
		{
			"<leader>rI",
			function()
				return require("refactoring").refactor("Inline Function")
			end,
			mode = { "n", "x" },
			expr = true,
			desc = "Inline function",
		},
		{
			"<leader>ri",
			function()
				return require("refactoring").refactor("Inline Variable")
			end,
			mode = { "n", "x" },
			expr = true,
			desc = "Inline variable",
		},
		{
			"<leader>rbb",
			function()
				return require("refactoring").refactor("Extract Block")
			end,
			mode = { "n", "x" },
			expr = true,
			desc = "Extract block",
		},
		{
			"<leader>rbf",
			function()
				return require("refactoring").refactor("Extract Block To File")
			end,
			mode = { "n", "x" },
			expr = true,
			desc = "Extract block to file",
		},
	},
}
