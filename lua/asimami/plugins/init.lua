local M = {}

--- Collect all plugin/theme modules, deduplicate specs, and return (specs, configs).
--- @return vim.pack.Spec[] specs
--- @return function[] configs
M.collect = function()
  local seen_srcs = {}
  ---@type vim.pack.Spec[]
  local all_specs = {}
  ---@type function[]
  local all_configs = {}

  ---@param path string
  ---@param lua_prefix string
  local function scan_dir(path, lua_prefix)
    local handle = vim.uv.fs_scandir(path)
    if not handle then
      return
    end
    while true do
      local name, ftype = vim.uv.fs_scandir_next(handle)
      if not name then
        break
      end
      if ftype == 'file' and name:match '%.[l]ua$' and name ~= 'init.lua' then
        local relpath = path:sub(#lua_prefix + 6):gsub('/', '.')
        local modname = (relpath ~= '' and relpath .. '.' or '') .. name:match '(.+)%.lua'
        local ok, mod = pcall(require, modname)
        if ok and type(mod) == 'table' then
          if mod.specs then
            for _, spec in ipairs(mod.specs) do
              local key = spec.src or ''
              if not seen_srcs[key] then
                seen_srcs[key] = true
                table.insert(all_specs, spec)
              end
            end
          end
          if type(mod.config) == 'function' then
            table.insert(all_configs, mod.config)
          end
        end
      end
    end
  end

  local my_dir = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:match '@(.*)', ':p:h')
  local lua_root = my_dir:match '(.+)/lua'
  scan_dir(my_dir, lua_root)

  local themes_dir = lua_root .. '/lua/asimami/themes'
  if vim.uv.fs_stat(themes_dir) then
    scan_dir(themes_dir, lua_root)
  end

  return all_specs, all_configs
end

--- Run all config functions.
--- @param function[] configs
M.run_configs = function(configs)
  for _, fn in ipairs(configs) do
    local ok, err = pcall(fn)
    if not ok then
      vim.schedule(function()
        vim.notify('Plugin config error: ' .. tostring(err), vim.log.levels.ERROR)
      end)
    end
  end
end

return M
