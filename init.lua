local require_all = require("scripts.require_all")

-- IMPORTANT: MUST BE BEFORE setup_lazy
require("config.keymaps")
-- load plugins
require("setup_lazy")

require_all("config.autoload", { recursive = true })
