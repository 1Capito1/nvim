return {
    {
        "folke/snacks.nvim",
        opts = {
            picker = {
            },

            scratch = {
            },

            scroll = {
            },

            notifier = {

            },

            indent = {
            },

            image = {
            },

            dashboard = {
            },

            input = {
            },

            lazygit = {
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

            -- scratch
            { "<leader>s", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },

            -- notifier
            --@param opts? snacks.notifier.history
            { "<leader><leader>s", function() Snacks.notifier.show_history(opts) end, desc = "Show notification history" },
            
            { "<leader>gs", function() Snacks.lazygit.open() end, desc = "Open LazyGit" },
        },

    }
}
