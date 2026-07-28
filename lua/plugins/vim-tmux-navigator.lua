return {
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
		"TmuxNavigatorProcessList",
	},
	keys = {
		{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
		{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
		{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
		{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
		{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
	},
	init = function()
		vim.keymap.set("t", "<c-h>", "<c-\\><c-n><cmd>TmuxNavigateLeft<cr>")
		vim.keymap.set("t", "<c-j>", "<c-\\><c-n><cmd>TmuxNavigateDown<cr>")
		vim.keymap.set("t", "<c-k>", "<c-\\><c-n><cmd>TmuxNavigateUp<cr>")
		vim.keymap.set("t", "<c-l>", "<c-\\><c-n><cmd>TmuxNavigateRight<cr>")
	end,
}
