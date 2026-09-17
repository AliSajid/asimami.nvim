local M = {}

-- Helper function to set up custom filetype detection
-- @param pattern: The autocmd file-name pattern to match (e.g. '*.txt', 'DESCRIPTION')
-- @param filetype: The filetype to set for matching files (e.g. 'text', 'markdown')
-- @param test: An optional function to test additional conditions before setting the filetype
local function setup_custom_filetype(pattern, filetype, test)
  -- Create or get the augroup for custom filetypes
  local group = vim.api.nvim_create_augroup('CustomFileTypes', { clear = false })

  -- Create an autocmd for BufRead and BufNewFile events
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = pattern,
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

-- Public interface to register a filetype by file extension
-- @param extension: The file extension to detect
-- @param filetype: The filetype to set for the detected extension
-- @param test: An optional function to test additional conditions before setting the filetype
M.register = function(extension, filetype, test)
  setup_custom_filetype('*.' .. extension, filetype, test)
end

-- Public interface to register a filetype by a raw autocmd file-name pattern.
-- Use this for extensionless files (e.g. 'DESCRIPTION', 'Makefile').
-- @param pattern: The autocmd pattern to match (see `:help autocmd-patterns`)
-- @param filetype: The filetype to set for matching files
-- @param test: An optional function to test additional conditions before setting the filetype
M.register_pattern = function(pattern, filetype, test)
  setup_custom_filetype(pattern, filetype, test)
end

-- Method to register multiple filetypes from a list
-- @param filetype_list: A list of tables containing extension (or pattern), filetype, and optional test function
M.register_from_list = function(filetype_list)
  for _, ft in ipairs(filetype_list) do
    if ft.pattern then
      M.register_pattern(ft.pattern, ft.filetype, ft.test)
    else
      M.register(ft.extension, ft.filetype, ft.test)
    end
  end
end

return M
