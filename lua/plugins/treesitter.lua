return {
	{
		{
			"nvim-treesitter/nvim-treesitter",
			branch = "main",
			lazy = false,
			build = ":TSUpdate",
			config = function()
				vim.api.nvim_create_autocmd("FileType", {
					pattern = "*",
					callback = function()
						local ok = pcall(vim.treesitter.start)
						if ok then
							vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
							vim.wo[0][0].foldmethod = "expr"
							vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
						end
					end,
				})
				vim.g.loaded_nvim_treesitter = 1
			end,
		},
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		lazy = true,
	},

	{
		"lewis6991/ts-install.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("ts-install").setup({
				ensure_install = {
					"rust",
					"lua",
					"c",
					"bash",
					"nu",
					"vimdoc",
				},
				auto_install = true,
			})
		end,
	},
}
