return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
	keys = function()
		local harpoon = require("harpoon")
		return {
			{ "<leader>ha", function() harpoon:list():add() end, desc = "Harpoon: Add file" },
			{ "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon: Menu" },
			{ "<A-1>", function() harpoon:list():select(1) end, desc = "Harpoon: File 1" },
			{ "<A-2>", function() harpoon:list():select(2) end, desc = "Harpoon: File 2" },
			{ "<A-3>", function() harpoon:list():select(3) end, desc = "Harpoon: File 3" },
			{ "<A-4>", function() harpoon:list():select(4) end, desc = "Harpoon: File 4" },
		}
	end,
}
