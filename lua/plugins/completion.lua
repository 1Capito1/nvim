return {
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "1.*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = 'default',
            },
            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = 'mono'
            },

            completion = {
                accept = { auto_brackets = { enabled = true } },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 250,
                    treesitter_highlighting = true,
                    window = { border = "rounded" },
                },
            },

            signature = {
                enabled = true,
                window = { border = "rounded" },
            },

            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = {
            "sources.default"
        }
    }
}
