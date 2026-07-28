local null_ls = require("null-ls")
local action = require("defgen").code_action()
null_ls.register(action)
null_ls.setup({})
