local M = {}
function M.require_all(dir, opts)
    opts = opts or {}
    local base = vim.fn.stdpath("config") .. "/lua"
    local files = vim.fn.glob(base .. dir .. "/*.lua", false, true)
    table.sort(files)

    for _, file in ipairs(files) do
        local mod = file
            :gsub("^" .. vim.pesc(base), "")
            :gsub("%.lua$", "")
            :gsub("/", ".")
        if opts.reload then package.loaded[mod] = nil end
        local ok, err = pcall(require, mod)
        if not ok then
            vim.notify(("require(%s) failed: %s"):format(mod, err), vim.log.levels.ERROR)
        end
    end
end
return M
