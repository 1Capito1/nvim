return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            messages = {
                enable = false,
            },
            notify = {
                enabled = false,
            },
            lsp = {
                progress = {
                    enabled = false,
                }
            }
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
    }
}
