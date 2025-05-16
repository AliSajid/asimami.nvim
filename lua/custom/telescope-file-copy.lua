local M = {}

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local dropdown = require("telescope.themes").get_dropdown()
local actions = require "telescope.actions"
local action_state = require("telescope.actions.state")


M.copy_filename = function(state)
  -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
  -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
  local node = state.tree:get_node()
  local filepath = node:get_id()
  local filename = node.name
  local modify = vim.fn.fnamemodify


  local results = {
    { prefix = "Path Relative to $CWD: ",       res_value = modify(filepath, ':.'), sort_order = 1 },
    { prefix = "Path Relative to $HOME: ",      res_value = modify(filepath, ':~'), sort_order = 2 },
    { prefix = "Absolute Path: ",               res_value = filepath,               sort_order = 3 },
    { prefix = "Just the File Name: ",          res_value = filename,               sort_order = 4 },
    { prefix = "File Name without Extension: ", res_value = modify(filename, ':r'), sort_order = 5 },
    { prefix = "File Extension without Name: ", res_value = modify(filename, ':e'), sort_order = 6 },
  }

  pickers.new(dropdown, {
    prompt_title = "Copy Filename or Path",
    finder = finders.new_table(
      {
        results = results,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry.prefix .. entry.res_value,
            ordinal = entry.sort_order
          }
        end
      }
    ),
    -- sorter = conf.generic_sorter(),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(
        function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          -- print(vim.inspect(selection))
          vim.fn.setreg('"', selection.value.res_value)
          local message = "Copied " .. selection.value.res_value .. " to register \""
          vim.notify(message)
        end
      )
      return true
    end
  }):find()
end


return M
