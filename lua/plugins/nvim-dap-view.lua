return {
	{
		"igorlfs/nvim-dap-view",
		opts = {
			winbar = {
				controls = {
					enabled = true,
				},
			},
		},
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
}
