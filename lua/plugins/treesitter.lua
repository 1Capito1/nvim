return {
    {
        { "nvim-treesitter/nvim-treesitter", branch = "master", lazy = false, build = ":TSUpdate" }
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        lazy = true,
    }

}
