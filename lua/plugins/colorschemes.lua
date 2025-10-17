return {
	{
		"thesimonho/kanagawa-paper.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},

	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = true,
		opts = {},
	},

	{ "folke/tokyonight.nvim" },

	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				themes = {
					"gruvbox",
					"kanagawa-paper-ink",
					"tokyonight-storm",
					"tokyonight-night",
					"tokyonight-moon",
				},
				livePreview = true,
			})
		end,
	},
}
