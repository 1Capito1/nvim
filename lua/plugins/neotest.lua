return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "rouge8/neotest-rust"
        },

        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-rust")
                }
            })
        end,

        keys = {
            { "<leader>tn", function() require("neotest").run.run() end,                     desc = "Run nearest test" },
            { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,   desc = "Run file tests" },
            { "<leader>ts", function() require("neotest").summary.toggle() end,              desc = "Toggle summary" },
            { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Open test output" },
            { "<leader>tO", function() require("neotest").output_panel.toggle() end,         desc = "Toggle output panel" },
        }
    }
}
