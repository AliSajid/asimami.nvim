local config_dir = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:match '@(.*)', ':p:h')
package.path = config_dir .. '/lua/?.lua;' .. config_dir .. '/lua/?/init.lua;' .. package.path

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Load the personal options set up
require 'asimami.options'

-- Load the personal keybind mappings
require 'asimami.mappings'

-- Load the asimami filetypes
local filetypes = require 'asimami.filetypes'
local filetype_overrides = require 'asimami.overrides.filetypes'
filetypes.register_from_list(filetype_overrides)

-- [[ Install plugins via vim.pack ]]
local pack_runner = require 'asimami.plugins'
local specs, configs = pack_runner.collect()

if #specs > 0 then
  vim.pack.add(specs, { confirm = false })
end

-- Run plugin configurations after all specs are added to rtp
pack_runner.run_configs(configs)

-- Colorscheme is configured in lua/asimami/themes/catppuccin.lua
local ok = pcall(vim.cmd.colorscheme, 'catppuccin-frappe')
if not ok then
  vim.notify('colorscheme catppuccin-frappe not found yet (plugins not installed)', vim.log.levels.WARN)
end

-- load asimami autocommands
require 'asimami.autocommands'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
