return {
	{
		"mfussenegger/nvim-lint",
		dependencies = {
			{
				"rshkarin/mason-nvim-lint",
				dependencies = { "mason-org/mason.nvim" },
				opts = {
					ensure_installed = { "markdownlint", "shellcheck" },
					automatic_installation = true,
				},
			},
		},
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				markdown = { "markdownlint" },
				sh = { "shellcheck" },
				bash = { "shellcheck" },
				zsh = { "shellcheck" },
				go = { "golangcilint" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
