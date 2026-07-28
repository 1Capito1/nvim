return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.Config
    config = function()
        require("oil").setup({
            default_file_browser=true,
	    view_options = {
		    show_hidden = true,
	    },
	    keymaps = {
		    ["<C-h>"] = false,
		    ["<C-l>"] = false,
	    },
        })
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
}

