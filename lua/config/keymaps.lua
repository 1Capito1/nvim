vim.g.mapleader = " "
local set = vim.keymap.set

set("n", "-", ":Oil<CR>", {})

set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format Buffer" })

set("n", "gd", vim.lsp.buf.definition, { desc = "Go To Definition" })
set("n", "gD", vim.lsp.buf.declaration, { desc = "Go To Declaration" })
set("n", "gi", vim.lsp.buf.implementation, { desc = "Go To Implementation " })
set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename Under Cursor" })
