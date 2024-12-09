return {
  [1] = 'R-nvim/R.nvim',
  version = '~0.1.0',
  lazy = false,
  config = function()
    -- Create a table with the options to be passed to setup()
    local opts = {
      hooks = {
        on_filetype = function()
          vim.api.nvim_buf_set_keymap(0, 'n', '<Enter>', '<Plug>RDSendLine', {})
          vim.api.nvim_buf_set_keymap(0, 'v', '<Enter>', '<Plug>RSendSelection', {})
        end,
      },
      R_app = 'radian',
      R_args = {},
      bracketed_paste = true,
      min_editor_width = 72,
      config_tmux = false,
      convert_range_int = true,
      close_term = false,
      objbr_mappings = {
        c = 'class',
        ['<localleader>gg'] = 'head({object}, n = 15)',
        v = function()
          require('r.browser').toggle_view()
        end,
      },
      auto_scroll = true,
      wait = 1000,
      synctex = true,
      pdfviewer = 'skimpdf',
      auto_quit = true,
      view_df = {
        open_app = 'terminal:vd',
      },
      disable_cmds = {
        'RClearConsole',
        'RCustomStart',
        'RSPlot',
        'RSaveClose',
      },
    }
    -- Check if the environment variable "R_AUTO_START" exists.
    -- If using fish shell, you could put in your config.fish:
    -- alias r "R_AUTO_START=true nvim"
    if vim.env.R_AUTO_START == 'true' then
      opts.auto_start = 'always'
    end
    require('r').setup(opts)
  end,
}
