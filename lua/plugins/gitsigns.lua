return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"<leader>gb",
				function()
					require("gitsigns").toggle_current_line_blame()
				end,
				{ desc = "Toggle current blame line" },
			},
		},
	},
}
