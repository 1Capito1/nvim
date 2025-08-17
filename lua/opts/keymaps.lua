local ts = require("telescope.builtin")
local set = vim.keymap.set

set("n", "-", ":Oil<CR>")
set("n", "<leader>f", vim.lsp.buf.format, { silent = false })
set("n", "<leader>pf", ts.find_files, {})
set("n", "<leader>ps", ts.live_grep, {})
set("n", "<leader>pb", ts.buffers, {})
set("n", "<leader>pd", ts.diagnostics, {})
set("n", "gd", ts.lsp_definitions, {})
