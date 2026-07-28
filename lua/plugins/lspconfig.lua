return {
	{ "neovim/nvim-lspconfig" },

	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			automatic_enable = {
				-- rust_analyzer is managed by rustaceanvim (see plugins/rust.lua);
				-- letting mason-lspconfig auto-enable it too would attach a second client
				exclude = { "clangd", "jdtls", "rust_analyzer" },
			},
			ensure_installed = { "clangd", "bashls", "postgres_lsp" },
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)
			-- Clangd Config
			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--compile-commands-dir=build",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
				},
				root_markers = { "compiler_commands.json", ".git" },
			})

			-- Nushell Config
			vim.lsp.config("nushell", {
				cmd = { "nu", "--lsp" },
				filetypes = { "nu" },
			})

			-- Bashls Config (The missing piece for .zshrc)
			vim.lsp.config("bashls", {
				cmd = { "bash-language-server", "start" },
				-- Adding zsh here is mandatory for .zshrc support
				filetypes = { "sh", "bash", "zsh" },
				-- We include .zshrc as a marker so it anchors to your home dir
				root_markers = { ".git", ".zshrc", ".shellcheckrc" },
				settings = {
					bashIde = {
						-- Ensures the LSP indexes zsh files for completions
						globPattern = "*@(.sh|.inc|.bash|.command|.zsh|.zshrc)",
					},
				},
			})

			-- Postgres LSP Config
			vim.lsp.config("postgres_lsp", {
				cmd = { "postgres-language-server", "lsp-proxy" },
				filetypes = { "sql" },
				root_markers = { ".git" },
				single_file_support = true,
			})

			-- Enable everything
			vim.lsp.enable("nushell")
			vim.lsp.enable("clangd")
			vim.lsp.enable("bashls")
			vim.lsp.enable("postgres_lsp")
		end,
	},
}
