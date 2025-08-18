
local set = vim.keymap.set
return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            local gs = require("gitsigns")
            gs.setup({})
            set("n", "<leader>gb", gs.blame)
        end,
    },
    {
        'sindrets/diffview.nvim',
        config = function ()
            local diffview_lib = require('diffview.lib')
            set("n", "<leader>gd", function ()
                vim.notify("Hello")
                if next(diffview_lib.views) == nil then
                    vim.cmd("DiffviewOpen")
                else
                    vim.cmd("DiffviewClose")
                end
            end)
        end
    }
}
