return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{ "<leader>dc", function() require("dap").continue() end, desc = "Debug: Continue" },
			{ "<leader>do", function() require("dap").step_over() end, desc = "Debug: Step Over" },
			{ "<leader>di", function() require("dap").step_into() end, desc = "Debug: Step Into" },
			{ "<leader>dO", function() require("dap").step_out() end, desc = "Debug: Step Out" },
			{ "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Debug: Conditional Breakpoint",
			},
			{ "<leader>dr", function() require("dap").repl.toggle() end, desc = "Debug: Toggle REPL" },
			{ "<leader>dl", function() require("dap").run_last() end, desc = "Debug: Run Last" },
			{ "<leader>dq", function() require("dap").terminate() end, desc = "Debug: Terminate" },
			{ "<leader>dv", function() require("dap-view").toggle() end, desc = "Debug: Toggle View" },
		},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		config = function()
			require("mason-nvim-dap").setup({
				-- "python" here is the mason-nvim-dap adapter name (maps to the
				-- "debugpy" mason package), not a mason package name itself.
				ensure_installed = { "codelldb", "python" },
				automatic_installation = true,
				handlers = {
					-- nvim-dap-python (plugins/python.lua) owns dap.adapters.python
					-- and dap.configurations.python outright; skip mason-nvim-dap's
					-- own default python handler so they don't race.
					python = function() end,
				},
			})

			local dap = require("dap")

			dap.configurations.rust = {
				{
					name = "Debug executable (codelldb)",
					type = "codelldb",
					request = "launch",
					program = function()
						local cwd = vim.fn.getcwd()
						return vim.fn.input("Path to executable: ", cwd .. "/target/debug/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
				{
					name = "Debug tests (codelldb)",
					type = "codelldb",
					request = "launch",
					program = function()
						-- Run cargo test to build the test executable
						vim.fn.system("cargo test --no-run")
						local cwd = vim.fn.getcwd()
						return vim.fn.input("Path to test executable: ", cwd .. "/target/debug/deps/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
				{
					name = "Debug current package (codelldb)",
					type = "codelldb",
					request = "launch",
					program = function()
						-- Get the package name from Cargo.toml
						local handle =
							io.popen("cargo metadata --no-deps --format-version 1 | jq -r '.packages[0].name'")
						local package_name = handle:read("*a"):gsub("%s+", "")
						handle:close()

						local cwd = vim.fn.getcwd()
						return cwd .. "/target/debug/" .. package_name
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
				{
					name = "Debug specific test (codelldb)",
					type = "codelldb",
					request = "launch",
					program = function()
						-- Ask for the test name
						local test_name = vim.fn.input("Test name: ", "", "file")

						-- Store it globally so args can access it
						vim.g.dap_test_name = test_name

						-- Build the test
						vim.fn.system("cargo test --no-run " .. test_name)

						-- Find the executable
						local handle = io.popen(
							"cargo test --no-run --message-format=json "
								.. test_name
								.. " 2>/dev/null | jq -r 'select(.executable != null) | .executable' | head -n1"
						)
						if not handle then
							vim.notify("Failed to find test executable", vim.log.levels.WARN)
							return nil
						end
						local executable = handle:read("*a"):gsub("%s+", "")
						handle:close()

						if executable == "" then
							vim.notify("Could not find executable for test: " .. test_name, vim.log.levels.ERROR)
							return nil
						end

						return executable
					end,
					args = function()
						return { vim.g.dap_test_name, "--exact", "--nocapture" }
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

			pcall(require, "dap-rust")
		end,
	},
}
