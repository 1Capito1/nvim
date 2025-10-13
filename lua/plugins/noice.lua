return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            messages = {
                enable = false,
            }
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify"
        }
    }
}
