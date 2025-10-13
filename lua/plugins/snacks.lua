return {
    {
        "folke/snacks.nvim",
        opts = {
            picker = {
            },
        },
        keys = {
            -- picker
            { "<leader>pf", function() Snacks.picker.files() end, desc = "Find Files" },
            { "<leader>ps", function() Snacks.picker.grep() end, desc = "grep" },
            { "<leader>pgb", function() Snacks.picker.git_branches() end, desc = "git branches" },
            { "<leader>pgl", function() Snacks.picker.git_log() end, desc = "git log" },
            { "<leader>t", function() Snacks.explorer() end, desc = "tree" },
            { "<leader>h", function() Snacks.picker.help() end, desc = "help pages" },
            { "<leader>pa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
        }
    }
}
