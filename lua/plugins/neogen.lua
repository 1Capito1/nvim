return {
	"danymat/neogen",
	config = function()
		require("neogen").setup({
			enabled = true,
			snippet_engine = "luasnip",
		})
	end,
	keys = {
		{
			"<leader>ng",
			function()
				require("neogen").generate()
			end,
			desc = "Generate Documents",
		},
	},
}
