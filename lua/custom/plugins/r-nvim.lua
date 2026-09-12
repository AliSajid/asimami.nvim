return {
  'R-nvim/R.nvim',

  -- R.nvim is a filetype plugin and should be available before R files
  -- are opened. This is also the configuration recommended by R.nvim
  -- when lazy.nvim's default lazy-loading is enabled.
  lazy = false,

  -- Track the mainline v1.x release
  version = '1.*',

  config = function()
    ---@type RConfigUserOpts
    local opts = {
      ----------------------------------------------------------------------
      -- R CONSOLE
      ----------------------------------------------------------------------

      -- Use `arf` as the interactive R console.
      --
      -- This is intentional rather than `radian`: radian is no longer
      -- actively developed, while its README currently recommends `arf`
      -- as the active alternative.
      R_app = 'arf',

      -- Arguments passed to R/arf.
      --
      -- Use '--quiet' for preventing the startup banner from eating space in
      -- the interactive console
      -- Use '--no-save' to disable saving `.RData`, making the session
      -- disposable
      R_args = {
        '--quiet',
        '--no-save',
      },

      ------------------------------------------------------------------------
      -- SENDING CODE TO R
      ------------------------------------------------------------------------

      -- Wrap multiline code in bracketed-paste escape sequences.
      --
      -- This makes sending selections/blocks of R code considerably
      -- more reliable with interactive terminals.
      bracketed_paste = true,

      ------------------------------------------------------------------------
      -- EDITOR / R CONSOLE LAYOUT
      ------------------------------------------------------------------------

      -- Keep at least this much editor width when the R console opens.
      min_editor_width = 72,
      rconsole_width = 78,

      -- Do not use R.nvim's special tmux configuration.
      --
      -- This is appropriate because my current workflow uses Neovim's
      -- built-in terminal rather than a tmux-managed R session.
      config_tmux = false,

      -- Automatically keep the R console scrolled to the bottom.
      auto_scroll = true,

      -- When Neovim exits, also quit the R process without saving the
      -- workspace.
      auto_quit = true,

      ------------------------------------------------------------------------
      -- ROXYGEN2
      ------------------------------------------------------------------------

      -- Enable Roxygen-aware highlighting and completion.
      --
      -- This is particularly useful for R package development:
      --   - Roxygen tag completion
      --   - R help keyword completion
      --   - R completion inside @examples
      roxygen_hl = true,

      ------------------------------------------------------------------------
      -- OBJECT BROWSER
      ------------------------------------------------------------------------

      objbr_mappings = {
        -- Show the class of the object under the cursor.
        c = 'class',

        -- Show a compact preview of the selected object.
        ['<localleader>gg'] = 'head({object}, n = 15)',

        -- Toggle the object's data view.
        v = function() require('r.browser').toggle_view() end,
      },

      ------------------------------------------------------------------------
      -- COMMANDS WE DON'T WANT
      ------------------------------------------------------------------------

      -- Remove commands that aren't part of the workflow.
      --
      -- This keeps the command namespace a little cleaner.
      disable_cmds = {
        'RCustomStart',
        'RSaveClose',
      },

      ----------------------------------------------------------------------
      -- R FILETYPE CUSTOMIZATIONS
      ----------------------------------------------------------------------

      hook = {
        on_filetype = function()
          -- Execute the current line and move to the next line.
          vim.keymap.set('n', '<Enter>', '<Plug>RDSendLine', {
            buffer = true,
            desc = 'R: send line',
          })

          -- Execute the visual selection.
          vim.keymap.set('v', '<Enter>', '<Plug>RSendSelection', {
            buffer = true,
            desc = 'R: send selection',
          })

          -- Generate a Roxygen skeleton.
          --
          -- This intentionally replaces R.nvim's default <localleader>rd
          -- mapping, which normally means RSetwd.
          vim.keymap.set('n', '<localleader>rd', '<Plug>Roxygenize', {
            buffer = true,
            desc = 'R: add Roxygen skeleton',
          })
        end,
      },
    }

    --------------------------------------------------------------------------
    -- OPTIONAL AUTOMATIC R STARTUP
    --------------------------------------------------------------------------

    -- Start R automatically only when explicitly requested:
    --
    --     R_AUTO_START=true nvim
    --
    -- This also starts the Object Browser.
    if vim.env.R_AUTO_START == 'true' then
      opts.auto_start = 'on startup'
      opts.objbr_auto_start = true
    end

    require('r').setup(opts)
  end,
}
