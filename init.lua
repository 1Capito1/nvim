-- IMPORTANT: MUST BE BEFORE setup_lazy
require("config.keymaps")
-- load plugins

require("setup_lazy")
require("config.lsp")
require("config.code-actions")

local require_all = require("scripts.require_all")
require_all("config.autoload", { recursive = true })

vim.cmd([[ colorscheme tokyonight-moon ]])
