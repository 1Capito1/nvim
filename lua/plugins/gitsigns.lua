return {
    {
        "lewis6991/gitsigns.nvim",
        keys = {
            {
                "<leader>gb",
                function()
                    require("gitsigns").toggle_current_line_blame()
                end,
                { desc = "Toggle current blame line" }
            }
        }
    }
}
