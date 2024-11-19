local treesitter = require 'custom.overrides.treesitter'
return { -- Highlight, edit, and navigate code
  [1] = 'nvim-treesitter/nvim-treesitter',
  dependencies = {
    { [1] = 'nvim-treesitter/nvim-treesitter-context', opts = treesitter.treesitter_context or {}, event = 'BufReadPost' },
    -- { [1] = 'nvim-treesitter/nvim-treesitter-textobjects', opts = treesitter.treesitter_textobjects or {} },
    {
      [1] = 'IndianBoy42/tree-sitter-just',
      opts = treesitter.treesitter_just or {},
    },
    {
      [1] = 'Wansmer/treesj',
      keys = { { [1] = '<leader>m', '<CMD>TSJToggle<CR>', desc = 'Toggle Treesitter Join' } },
      cmd = { 'TSJToggle' },
      opts = { use_default_keymaps = false },
      init = function()
        local map = vim.keymap.set
        map('n', '<leader>tt', '<CMD>TSJToggle<CR>', { desc = 'Toggle Treesitter Join/Split' })
      end,
    },
  },
  build = ':TSUpdate',
  opts = {
    ensure_installed = treesitter.ensure_installed,
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
  config = function(_, opts)
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)
  end,
}
