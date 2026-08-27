return {
	{
		"linux-cultist/venv-selector.nvim",
		ft = "python",
		opts = {
			options = {
				picker = "snacks", -- snacks.nvim already used elsewhere (code-actions.lua)
				notify_user_on_venv_activation = true,
				-- Keep nvim-dap-python's debugged-program interpreter in sync
				-- with whatever venv gets activated (its own VIRTUAL_ENV
				-- detection only sees venvs active *before* nvim starts).
				on_venv_activate_callback = function(venv_path)
					local ok, dap_python = pcall(require, "dap-python")
					if ok then
						dap_python.resolve_python = function()
							return venv_path
						end
					end
				end,
			},
		},
		keys = {
			{ "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python Venv" },
			{ "<leader>vc", "<cmd>VenvSelectCache<cr>", desc = "Activate Cached Venv" },
		},
	},

	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			-- Adapter host runs debugpy itself; point it at mason's install.
			-- The debugged program's own interpreter comes from resolve_python
			-- (wired above by venv-selector) or VIRTUAL_ENV/.venv autodetection.
			local mason_debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(mason_debugpy)
			require("dap-python").test_runner = "pytest"
		end,
		keys = {
			{ "<leader>dpm", function() require("dap-python").test_method() end, desc = "Debug: Test Method (Python)" },
			{ "<leader>dpc", function() require("dap-python").test_class() end, desc = "Debug: Test Class (Python)" },
			{
				"<leader>dps",
				function() require("dap-python").debug_selection() end,
				mode = "v",
				desc = "Debug: Selection (Python)",
			},
		},
	},
}
