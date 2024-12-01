local M = {}

-- Helper function to set up custom filetype detection
-- @param extension: The file extension to detect (e.g., 'txt', 'md')
-- @param filetype: The filetype to set for the detected extension (e.g., 'text', 'markdown')
-- @param test: An optional function to test additional conditions before setting the filetype
local function setup_custom_filetype(extension, filetype, test)
  -- Create or get the augroup for custom filetypes
  local group = vim.api.nvim_create_augroup('CustomFileTypes', { clear = false })

  -- Create an autocmd for BufRead and BufNewFile events
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    -- Pattern to match files with the given extension
    pattern = '*.' .. extension,
    -- Callback function to set the filetype
    callback = function()
      -- If a test function is provided and it returns false, do not set the filetype
      if test and not test() then
        return
      end
      -- Set the buffer's filetype
      vim.bo.filetype = filetype
    end,
    -- Assign the autocmd to the custom filetypes group
    group = group,
  })
end

-- Public interface to register filetypes
-- @param extension: The file extension to detect
-- @param filetype: The filetype to set for the detected extension
-- @param test: An optional function to test additional conditions before setting the filetype
M.register = function(extension, filetype, test)
  setup_custom_filetype(extension, filetype, test)
end

-- Method to register multiple filetypes from a list
-- @param filetype_list: A list of tables containing extension, filetype, and optional test function
M.register_from_list = function(filetype_list)
  for _, ft in ipairs(filetype_list) do
    M.register(ft.extension, ft.filetype, ft.test)
  end
end

return M
