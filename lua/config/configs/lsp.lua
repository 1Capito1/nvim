-- lua_ls: unchanged
require("lspconfig").lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } }
        }
    }
})

-- ✅ Make java.nvim/JDTLS launch with a known-good JDK and flags
-- mason-lspconfig: keep this; DO NOT also try to configure jdtls via lspconfig
local mason_lsp = require("mason-lspconfig")
mason_lsp.setup({
    ensure_installed = { "lua_ls", "ts_ls" },
    automatic_installation = true,
    automatic_enable = true
})

require("lspconfig").jdtls.setup({
    on_exit = function(code, _, client_id)
        vim.schedule(function()
            if code ~= 0 then
                local cache = vim.fn.expand("~/.cache/jdtls")
                if vim.fn.isdirectory(cache) == 1 then
                    vim.notify("[LSP_DEBUG] non-zero jdtls exit, clearing cache")
                    vim.fn.delete(cache, "rf")
                end
            end
        end)
    end,
    handlers = {
        -- By assigning an empty function, you can remove the notifications
        -- printed to the cmd
        ["$/progress"] = function(_, _, _) end,
    },
})
