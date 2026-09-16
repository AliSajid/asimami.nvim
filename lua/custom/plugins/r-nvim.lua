return {
  specs = {
    { src = 'https://github.com/R-nvim/R.nvim' },
  },
  config = function()
    local opts = {
      R_app = 'arf',
      R_args = { '--quiet', '--no-save' },
      bracketed_paste = true,
      min_editor_width = 72,
      rconsole_width = 78,
      config_tmux = false,
      auto_scroll = true,
      auto_quit = true,
      roxygen_hl = true,
      objbr_mappings = {
        c = 'class',
        ['<localleader>gg'] = 'head({object}, n = 15)',
        v = function() require('r.browser').toggle_view() end,
      },
      disable_cmds = { 'RCustomStart', 'RSaveClose' },
      hook = {
        on_filetype = function()
          vim.keymap.set('n', '<Enter>', '<Plug>RDSendLine', { buf = 0, desc = 'R: send line' })
          vim.keymap.set('v', '<Enter>', '<Plug>RSendSelection', { buf = 0, desc = 'R: send selection' })
          vim.keymap.set('n', '<localleader>rd', '<Plug>Roxygenize', { buf = 0, desc = 'R: add Roxygen skeleton' })
        end,
      },
    }

    if vim.env.R_AUTO_START == 'true' then
      opts.auto_start = 'on startup'
      opts.objbr_auto_start = true
    end

    require('r').setup(opts)
  end,
}
