-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  [1] = 'mfussenegger/nvim-dap',

  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    -- Required by nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs and manages debug adapters
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go', -- Go debugger
    'mfussenegger/nvim-dap-python', -- Python debugger
  },
  keys = function(_, keys)
    local dap = require 'dap'
    local dapui = require 'dapui'
    return {
      -- Basic debugging keymaps, feel free to change to your liking!
      {
        [1] = '<F5>',
        [2] = function()
          dap.continue()
        end,
        desc = 'Debug: Start/Continue',
      },
      {
        [1] = '<F6>',
        [2] = function()
          dap.step_over()
        end,
        desc = 'Debug: Step Over',
      },
      {
        [1] = '<F7>',
        [2] = function()
          dap.step_into()
        end,
        desc = 'Debug: Step Into',
      },
      {
        [1] = '<F8>',
        [2] = function()
          dap.step_out()
        end,
        desc = 'Debug: Step Out',
      },
      {
        [1] = '<leader>b',
        [2] = function()
          dap.toggle_breakpoint()
        end,
        desc = 'Debug: Toggle Breakpoint',
      },
      {
        [1] = '<leader>B',
        [2] = function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set Breakpoint',
      },

      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      {
        [1] = '<F7>',
        [2] = function()
          dapui.toggle()
        end,
        desc = 'Debug: See last session result.',
      },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    ---@diagnostic disable-next-line: missing-fields
    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    ---@diagnostic disable-next-line: missing-fields
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      ---@diagnostic disable-next-line: missing-fields
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    local python_path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
    require('dap-python').setup(python_path)
  end,
}
