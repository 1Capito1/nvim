return {
    "mfussenegger/nvim-dap",
    {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = { "codelldb" },
                automatic_installation = true,
                handlers = {},
            })

            local dap = require("dap")

            require("dap").configurations.python = {
                {
                    type = "python",
                    request = "launch",
                    name = "Launch with input",
                    program = "${file}",
                    console = "integratedTerminal", -- <— key line
                },
            }

            dap.configurations.rust = {
                name = "Debug executable (codelldb)",
                type = "codelldb",
                request = "launch",
                program = function()
                    local cwd = vim.fn.getcwd()
                    return vim.fn.input("Path to executable: ", cwd .. "/target/debug/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            }

            pcall(require, "dap-rust")
        end
    }
}
