return {
  {
    [1] = 'folke/trouble.nvim',
    cmd = { 'Trouble', 'TroubleToggle', 'TodoTrouble' },
    dependencies = {
      {
        'folke/todo-comments.nvim',
      },
    },
    opts = {},
    init = function()
      local map = vim.keymap.set

      map('n', '<leader>t', '<CMD>Trouble diagnostics toggle<CR>', { desc = 'Toggle diagnostics' })
      map('n', '<leader>td', '<CMD>TodoTrouble keywords=TODO,FIX,FIXME,BUG,TEST,NOTE<CR>', { desc = 'Todo/Fix/Fixme' })
    end,
  },
  { [1] = 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  'b0o/schemastore.nvim',
  'dmmulroy/ts-error-translator.nvim',
  {
    [1] = 'utilyre/barbecue.nvim',
    event = 'LspAttach',
    dependencies = {
      'SmiteshP/nvim-navic',
    },
    opts = {},
  },
  {
    [1] = 'Fildo7525/pretty_hover',
    keys = { '<leader>k' },
    config = true,
  },
  {
    [1] = 'karb94/neoscroll.nvim',
    keys = { '<C-d>', '<C-u>' },
    opts = { mappings = {
      '<C-u>',
      '<C-d>',
    } },
  },
  {
    [1] = 'rainbowhxch/beacon.nvim',
    event = 'CursorMoved',
    cond = function()
      -- Don't load in neovide
      return not vim.g.neovide
    end,
  },
  {
    [1] = 'wakatime/vim-wakatime',
    lazy = false,
  },
  {
    [1] = 'jannis-baum/vivify.vim',
    event = 'BufRead *.md',
    config = function()
      vim.g.vivify_instand_refresh = 1
      vim.g.vivify_filetypes = { 'markdown', 'vimwiki' }
    end,
  },
  {
    [1] = 'jmbuhr/otter.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
  },
}
