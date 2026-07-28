return {
	"mfussenegger/nvim-dap",
	{
		"jay-babu/mason-nvim-dap.nvim",
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "codelldb" },
				automatic_installation = true,
				handlers = {},
			})

			local dap = require("dap")

			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch with input",
					program = "${file}",
					console = "integratedTerminal", -- <— key line
				},
			}

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
