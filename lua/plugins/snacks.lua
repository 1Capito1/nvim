local function fuzzy_oil()
	local find_command = {
		"fd",
		"--type",
		"d",
		"--color",
		"never",
	}
	vim.fn.jobstart(find_command, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			if data then
				local filtered = vim.tbl_filter(function(el)
					return el ~= ""
				end, data)

				local items = {}
				for _, v in ipairs(filtered) do
					table.insert(items, { text = v })
				end

				---@module 'snacks'
				Snacks.picker.pick({
					source = "directories",
					items = items,
					layout = { preset = "select" },
					format = "text",
					preview = function(item, ctx)
						if not ctx.preview_buf or not vim.api.nvim_buf_is_valid(ctx.preview_buf) then
							ctx.preview_buf = vim.api.nvim_create_buf(false, true)
						end

						vim.cmd(("Oil %s"):format(vim.fn.fnameescape(item.text)))
						local oil_buf = vim.api.nvim_get_current_buf()

						ctx:set_preview_buf(oil_buf)
					end,
					confirm = function(picker, item)
						picker:close()
						vim.cmd("Oil " .. vim.fn.fnameescape(item.text))
					end,
				})
			end
		end,
	})
end

return {
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				hidden = false,
				ignored = true,
			},

			scratch = {},

			scroll = {
				duration = { step = 5, total = 25 },
			},

			indent = {},

			image = {},

			dashboard = {},

			input = {},

			lazygit = {},

			terminal = {},

			notifier = { enabled = true },
		},
		keys = {
			-- picker
			{
				"<leader>pf",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>ps",
				function()
					Snacks.picker.grep()
				end,
				desc = "grep",
			},
			{
				"<leader>pd",
				function()
					fuzzy_oil()
				end,
				desc = "Search directories in Oil",
			},
			{
				"<leader>pgb",
				function()
					Snacks.picker.git_branches()
				end,
				desc = "git branches",
			},
			{
				"gu",
				function()
					Snacks.picker.lsp_references()
				end,
			},
			{
				"<leader>pgl",
				function()
					Snacks.picker.git_log()
				end,
				desc = "git log",
			},
			{
				"<leader>T",
				function()
					Snacks.explorer()
				end,
				desc = "tree",
			},
			{
				"<leader>he",
				function()
					Snacks.picker.help()
				end,
				desc = "help pages",
			},
			{
				"<leader>pa",
				function()
					Snacks.picker.autocmds()
				end,
				desc = "Autocmds",
			},
			{
				"<leader>pls",
				function()
					Snacks.picker.lsp_symbols({})
				end,
			},
			{
				"<leader>plS",
				function()
					Snacks.picker.lsp_workspace_symbols()
				end,
			},
			{
				"<leader>plC",
				function()
					Snacks.picker.lsp_workspace_symbols({
						symbols = { "Class" },
					})
				end,
			},
			{
				"<leader>plc",
				function()
					Snacks.picker.lsp_symbols({
						symbols = { "Class" },
					})
				end,
			},

			-- scratch
			{
				"<leader>s",
				function()
					Snacks.scratch()
				end,
				desc = "Toggle Scratch Buffer",
			},

			-- notifier
			--@param opts? snacks.notifier.history
			{
				"<leader><leader>s",
				function()
					Snacks.notifier.show_history(opts)
				end,
				desc = "Show notification history",
			},

			{
				"<leader>gs",
				function()
					Snacks.lazygit.open()
				end,
				desc = "Open LazyGit",
			},

			--@param cmd? string | string[]
			--@param opts? snacks.terminal.Opts
			{
				"<leader>ct",
				function()
					Snacks.terminal.toggle(cmd, opts)
				end,
				desc = "Toggle Terminal",
			},

			{
				"<leader>ld",
				function()
					Snacks.terminal.open({
						cmd = "lazydocker",
						cwd = vim.fn.getcwd(),
						border = "rounded",
						height = 0.9,
						width = 0.9,
					})
				end,
				desc = "Docker: Services (lazydocker)",
			},
		},
	},
}
