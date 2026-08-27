return {
	{ "neovim/nvim-lspconfig" },

	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			automatic_enable = {
				-- rust_analyzer is managed by rustaceanvim (see plugins/rust.lua);
				-- letting mason-lspconfig auto-enable it too would attach a second client
				-- basedpyright/ruff need custom settings applied before their first
				-- enable, so they're excluded here and enabled manually below
				exclude = { "clangd", "jdtls", "rust_analyzer", "basedpyright", "ruff" },
			},
			ensure_installed = { "clangd", "bashls", "postgres_lsp", "basedpyright", "ruff" },
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

			-- Basedpyright Config
			-- Owns hover/go-to-def/type checking. Ruff owns import organizing,
			-- so basedpyright's own organize-imports action is turned off to
			-- avoid the two conflicting on that specific action.
			vim.lsp.config("basedpyright", {
				settings = {
					basedpyright = {
						disableOrganizeImports = true,
						analysis = { typeCheckingMode = "standard" },
					},
				},
			})

			-- Ruff Config
			-- Owns linting, "Fix All", "Organize Imports". Hover is disabled below
			-- so basedpyright's hover wins instead of ruff's.
			vim.lsp.config("ruff", {})

			-- Enable everything
			vim.lsp.enable("nushell")
			vim.lsp.enable("clangd")
			vim.lsp.enable("bashls")
			vim.lsp.enable("postgres_lsp")
			vim.lsp.enable("basedpyright")
			vim.lsp.enable("ruff")

			-- Ruff/basedpyright both attach to python buffers; keep ruff from
			-- shadowing basedpyright's hover, and expose ruff's fix/organize
			-- actions as direct keymaps (also reachable via <leader>ca).
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client or client.name ~= "ruff" then
						return
					end
					client.server_capabilities.hoverProvider = false
					local buf = args.buf
					vim.keymap.set("n", "<leader>rf", function()
						vim.lsp.buf.code_action({
							context = { only = { "source.fixAll.ruff" }, diagnostics = {} },
							apply = true,
						})
					end, { buffer = buf, desc = "Ruff: Fix All" })
					vim.keymap.set("n", "<leader>ro", function()
						vim.lsp.buf.code_action({
							context = { only = { "source.organizeImports.ruff" }, diagnostics = {} },
							apply = true,
						})
					end, { buffer = buf, desc = "Ruff: Organize Imports" })
				end,
			})
		end,
	},
}
