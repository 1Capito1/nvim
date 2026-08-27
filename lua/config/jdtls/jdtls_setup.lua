local M = {}
function M:setup()
	-- See `:help vim.lsp.start` for an overview of the supported `config` options.
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	local workspace_dir = "/home/hesphaestus/development/jdtls_data/" .. project_name
	local java_cmd = vim.fn.expand("~/.sdkman/candidates/java/24.0.2.fx-zulu/bin/java")
	local mason_packages = vim.fn.expand("~/.local/share/nvim/mason/packages")
	local lombok_path = vim.fn.glob(mason_packages .. "/jdtls/lombok.jar")

	-- Debug (java-debug-adapter) and test (java-test) bundles, installed via
	-- `:MasonInstall java-debug-adapter java-test`. These get wired into
	-- nvim-dap and expose the "run/debug test" code lenses.
	local bundles = {
		vim.fn.glob(mason_packages .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
	}
	vim.list_extend(bundles, vim.split(vim.fn.glob(mason_packages .. "/java-test/extension/server/*.jar", true), "\n"))

	local config = {
		name = "jdtls",

		-- `cmd` defines the executable to launch eclipse.jdt.ls.
		-- `jdtls` must be available in $PATH and you must have Python3.9 for this to work.
		--
		-- As alternative you could also avoid the `jdtls` wrapper and launch
		-- eclipse.jdt.ls via the `java` executable
		-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
		cmd = {
			java_cmd,
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-Xmx2g",
			"-javaagent:" .. lombok_path,
			"--add-modules=ALL-SYSTEM",
			"--add-opens",
			"java.base/java.util=ALL-UNNAMED",
			"--add-opens",
			"java.base/java.lang=ALL-UNNAMED",

			"-jar",
			vim.fn.glob(
				"/home/hesphaestus/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
			),

			"-configuration",
			"/home/hesphaestus/.local/share/nvim/mason/packages/jdtls/config_linux",

			"-data",
			workspace_dir,
		},

		-- `root_dir` must point to the root of your project.
		-- See `:help vim.fs.root`
		root_dir = vim.fs.root(0, { "gradlew", "mvnw", "pom.xml", "settings.gradle", "settings.gradle.kts", ".git" }),

		-- Here you can configure eclipse.jdt.ls specific settings
		-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
		-- for a list of options
		settings = {
			java = {
				signatureHelp = { enabled = true },
				contentProvider = { preferred = "fernflower" },
				completion = {
					favoriteStaticMembers = {
						"org.junit.jupiter.api.Assertions.*",
						"org.mockito.Mockito.*",
					},
				},
			},
		},

		-- This sets the `initializationOptions` sent to the language server.
		-- `bundles` wires in the java-debug/java-test plugins above.
		init_options = {
			bundles = bundles,
			extendClientCapabilities = {
				resolveAdditionalTextEditsSupport = true,
			},
		},

		handlers = {
			["language/status"] = function(_, res) end,
			["$/progress"] = function(_, res) end,
		},

		on_attach = function(_, bufnr)
			require("jdtls").setup_dap({ config_overrides = {} })
			require("jdtls.dap").setup_dap_main_class_configs()

			local set = vim.keymap.set
			local opts = { buffer = bufnr }
			set("n", "<leader>jo", require("jdtls").organize_imports, vim.tbl_extend("force", opts, { desc = "Organize Imports" }))
			set("n", "<leader>jv", require("jdtls").extract_variable, vim.tbl_extend("force", opts, { desc = "Extract Variable" }))
			set("n", "<leader>jc", require("jdtls").extract_constant, vim.tbl_extend("force", opts, { desc = "Extract Constant" }))
			set("v", "<leader>jm", function()
				require("jdtls").extract_method(true)
			end, vim.tbl_extend("force", opts, { desc = "Extract Method" }))
			set("n", "<leader>jt", require("jdtls").test_nearest_method, vim.tbl_extend("force", opts, { desc = "Test Nearest Method" }))
			set("n", "<leader>jT", require("jdtls").test_class, vim.tbl_extend("force", opts, { desc = "Test Class" }))
			set("n", "<leader>ju", "<CMD>JdtUpdateConfig<CR>", vim.tbl_extend("force", opts, { desc = "Update Project Configuration" }))
		end,
	}
	require("jdtls").start_or_attach(config)
end

return M
