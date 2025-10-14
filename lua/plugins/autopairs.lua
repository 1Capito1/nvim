return {
    {
        "nvim-mini/mini.pairs",
        version = "*",
        config = function()
            require("mini.pairs").setup({})
        end
    },

    { "RRethy/nvim-treesitter-endwise" } -- techincally not autopairs, but provides similar functionality
}
