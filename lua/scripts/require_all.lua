-- Requires all Lua files in a given directory
---@param dir string: Directory path relative to your Neovim config
---@param opts table: Optional configuration table
--   - recursive: boolean (default: false) - whether to search subdirectories
--   - pattern: string (default: "%.lua$") - pattern to match files
local function require_all(dir, opts)
  opts = opts or {}
  local recursive = opts.recursive or false
  local pattern = opts.pattern or "%.lua$"
  
  -- Get the directory path relative to Neovim's runtime path
  local config_path = vim.fn.stdpath("config")
  local full_path = config_path .. "/lua/" .. dir:gsub("%.", "/")
  
  -- Check if directory exists
  if vim.fn.isdirectory(full_path) == 0 then
    vim.notify("Directory not found: " .. full_path, vim.log.levels.WARN)
    return
  end
  
  -- Scan directory for files
  local scandir = function(directory)
    local files = {}
    local handle = vim.loop.fs_scandir(directory)
    
    if handle then
      while true do
        local name, type = vim.loop.fs_scandir_next(handle)
        if not name then break end
        
        local file_path = directory .. "/" .. name
        
        if type == "file" and name:match(pattern) then
          table.insert(files, file_path)
        elseif type == "directory" and recursive and name ~= "." and name ~= ".." then
          local subfiles = scandir(file_path)
          for _, f in ipairs(subfiles) do
            table.insert(files, f)
          end
        end
      end
    end
    
    return files
  end
  
  local files = scandir(full_path)
  
  -- Require each file
  for _, file in ipairs(files) do
    -- Convert file path to require path
    local require_path = file:gsub(config_path .. "/lua/", "")
                             :gsub("%.lua$", "")
                             :gsub("/", ".")
    
    local ok, err = pcall(require, require_path)
    if not ok then
      vim.notify("Error loading " .. require_path .. ": " .. err, vim.log.levels.ERROR)
    end
  end
end

-- Example usage:
-- require_all("plugins")  -- requires all files in lua/plugins/
-- require_all("config.keymaps", { recursive = true })  -- recursively requires all files
-- require_all("utils", { pattern = "^helper_.*%.lua$" })  -- only files matching pattern

return require_all
