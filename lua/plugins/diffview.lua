return {
	"sindrets/diffview.nvim",
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff view open" },
		{ "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diff view close" },
		{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
	},
	opts = {
		keymaps = {
			diff3 = {
				{ "n", "<leader>co", "<cmd>diffget LOCAL<cr>",  { desc = "Accept ours" } },
				{ "n", "<leader>ct", "<cmd>diffget REMOTE<cr>", { desc = "Accept theirs" } },
				{ "n", "<leader>cb", "<cmd>diffget BASE<cr>",   { desc = "Accept base" } },
				{ "n", "]x",        "<cmd>]c<cr>",             { desc = "Next conflict" } },
				{ "n", "[x",        "<cmd>[c<cr>",             { desc = "Prev conflict" } },
			},
		},
	},
}
