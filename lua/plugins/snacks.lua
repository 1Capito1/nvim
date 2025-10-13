local function fuzzy_oil()
    local find_command = {
        "fd",
        "--type",
        "d",
        "--color",
        "never",
    }
    vim.fn.jobstart(find_command, {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if data then
                local filtered = vim.tbl_filter(function(el)
                    return el ~= ''
                end, data)
                
                local items = {}
                for _, v in ipairs(filtered) do
                    table.insert(items, { text = v })
                end
                
                ---@module 'snacks'
                Snacks.picker.pick({
                    source = 'directories',
                    items = items,
                    layout = { preset = "select" },
                    format = 'text',
                    confirm = function(picker, item)
                        picker:close()
                        vim.cmd('Oil ' .. item.text)
                    end,
                })
            end
        end,
    })
end

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

            terminal = {
                
            },
        },
        keys = {
            -- picker
            { "<leader>pf", function() Snacks.picker.files() end, desc = "Find Files" },
            { "<leader>ps", function() Snacks.picker.grep() end, desc = "grep" },
            { "<leader>pd", function() fuzzy_oil() end, desc = "Search directories in Oil" },
            { "<leader>pgb", function() Snacks.picker.git_branches() end, desc = "git branches" },
            { "<leader>pgl", function() Snacks.picker.git_log() end, desc = "git log" },
            { "<leader>T", function() Snacks.explorer() end, desc = "tree" },
            { "<leader>h", function() Snacks.picker.help() end, desc = "help pages" },
            { "<leader>pa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },

            -- scratch
            { "<leader>s", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },

            -- notifier
            --@param opts? snacks.notifier.history
            { "<leader><leader>s", function() Snacks.notifier.show_history(opts) end, desc = "Show notification history" },
            
            { "<leader>gs", function() Snacks.lazygit.open() end, desc = "Open LazyGit" },

            --@param cmd? string | string[]
            --@param opts? snacks.terminal.Opts
            { "<leader>ct", function() Snacks.terminal.toggle(cmd, opts) end, desc = "Toggle Terminal" },
        },

    }
}
