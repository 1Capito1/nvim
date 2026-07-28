return {
	{
		-- crates completion
		"saecki/crates.nvim",
		tag = "stable",
		config = function()
			require("crates").setup({})
		end,
	},

	{
		"mrcjkb/rustaceanvim",
		version = "^9",
		lazy = false, -- this plugin is already lazy, it self-loads on FileType rust
		init = function()
			-- must be set before the plugin's own FileType autocmd fires,
			-- so it goes in `init`, not `config`
			vim.g.rustaceanvim = {
				server = {
					default_settings = {
						["rust-analyzer"] = {
							check = {
								command = "clippy",
							},
							-- separate target dir so background clippy checks don't
							-- fight `cargo build`/`cargo run` over the lock file and
							-- force full rebuilds on both sides
							cargo = {
								targetDir = true,
							},
						},
					},
				},
			}
		end,
	},
}
