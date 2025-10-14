vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        vim.lsp.buf.format({
            async = false,
            bufnr = args.buf,
            filter = function(client)
                return client.supports_method("textDocument/formatting")
            end,
        })
    end
})
