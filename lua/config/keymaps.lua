vim.g.mapleader = " "
local set = vim.keymap.set

set("n", "-", ":Oil<CR>", {})

set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format Buffer" })
