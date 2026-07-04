return {
  [1] = 'nvim-mini/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    -- Fuzzy picker for mini.nvim ecosystem
    require('mini.pick').setup {
      icons = vim.g.have_nerd_font,
    }

    -- Faster LSP hover with mini.hover
    -- require('mini.hover').setup()

    -- Indentation guides (indentation markers)
    require('mini.indentscope').setup {
      -- depth = 4,
      -- style = 'purespace',
      -- highlight = 'MiniIndentscope',
      -- render = 'indent_blankline_provider',
      -- lazy = true,
      -- options = {
      --   tab_padding = true,
      --   space_padding = true,
      -- },
    }

    -- Comment/uncomment functionality
    require('mini.comment').setup {
      config = function()
        -- Uncomment to enable which-key mapping
        vim.keymap.set('n', '<leader>mc', require('mini.comment').comment, { desc = 'Toggle comment' })
        vim.keymap.set('v', '<leader>mc', require('mini.comment').comment_line, { desc = 'Toggle comment line' })
      end,
    }

    -- Folding with mini.fold
    -- require('mini.fold').setup {
    --   max_fold_level = 10,
    --   fold_open = '▾',
    --   fold_closed = '▸',
    --   indent_guides = false, -- enabled by mini.indentscope
    -- }

    -- Unicode icons
    require('mini.icons').setup {
      icons = vim.g.have_nerd_font and {} or {
        file = {
          default = '📄',
        },
      },
    }

    require('mini.extra').setup()

    -- Set up keymaps for mini.hover (faster LSP hover)
    -- vim.keymap.set('n', '<leader>kh', require('mini.hover').show, { desc = '[K]eyword/Show LSP [H]over' })

    -- Set up keymaps for mini.fold folding navigation
    -- vim.keymap.set('n', 'zo', require('mini.fold').unfold, { desc = '[Z]oom (unfold fold)' })
    -- vim.keymap.set('n', 'za', require('mini.fold').fold_all, { desc = '[Z]oom All (fold all)' })
    -- vim.keymap.set('n', 'zO', require('mini.fold').unfold_all, { desc = '[Z]oom Out (unfold all)' })
    -- vim.keymap.set('v', 'zo', require('mini.fold').unfold, { desc = '[Z]oom (unfold)' })
  end,
}
