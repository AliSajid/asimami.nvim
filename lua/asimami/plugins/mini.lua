return {
  specs = {
    { src = 'https://github.com/nvim-mini/mini.nvim' },
  },
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.surround').setup()

    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    require('mini.pick').setup { icons = vim.g.have_nerd_font }
    require('mini.indentscope').setup()

    require('mini.comment').setup {
      config = function()
        vim.keymap.set('n', '<leader>mc', require('mini.comment').comment, { desc = 'Toggle comment' })
        vim.keymap.set('v', '<leader>mc', require('mini.comment').comment_line, { desc = 'Toggle comment line' })
      end,
    }

    require('mini.icons').setup {
      icons = vim.g.have_nerd_font and {} or {
        file = { default = '📄' },
      },
    }

    require('mini.extra').setup()
  end,
}
