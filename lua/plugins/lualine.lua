return {
    {
        "linrongbin16/lsp-progress.nvim",
        config = function()
            require("lsp-progress").setup({})
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                sections = {
                    lualine_x = {function ()
                        return require("lsp-progress").progress()
                    end, "filetype" },
                },
            })
        end
    }
}
