require("lspconfig").lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } }
		}
	}
})

local mason_lsp = require("mason-lspconfig")

mason_lsp.setup({
	ensure_installed = { "lua_ls", "ts_ls" },
	automatic_installation = true,
	automatic_enable = true
})
