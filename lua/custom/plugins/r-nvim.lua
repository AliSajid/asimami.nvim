return {
  [1] = 'R-nvim/R.nvim',
  lazy = false,
  config = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<Enter>', '<Plug>RDSendLine', {})
    vim.api.nvim_buf_set_keymap(0, 'v', '<Enter>', '<Plug>RSendSelection', {})
    -- Create a table with the options to be passed to setup()
    local opts = {
      R_app = 'radian',
      R_args = {},
      bracketed_paste = true,
      min_editor_width = 72,
      config_tmux = false,
      convert_range_int = true,
      close_term = false,
      auto_scroll = true,
      wait = 1000,
      synctex = true,
      pdfviewer = 'skimpdf',
      csv_app = 'terminal:vd',
      auto_quit = true,
      disable_cmds = {
        'RClearConsole',
        'RCustomStart',
        'RSPlot',
        'RSaveClose',
      },
    }
    require('r').setup(opts)
  end,
}
