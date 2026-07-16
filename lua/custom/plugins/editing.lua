return {
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    'karb94/neoscroll.nvim',
    keys = { '<C-d>', '<C-u>' },
    opts = {
      mappings = {
        '<C-u>',
        '<C-d>',
      },
    },
  },
  {
    'rainbowhxch/beacon.nvim',
    event = 'CursorMoved',
    cond = function()
      -- Don't load in neovide
      return not vim.g.neovide
    end,
  },
  { 'm-demare/hlargs.nvim' },
  {
    'lukas-reineke/virt-column.nvim',
    opts = {
      virtcolumn = '+1,80,120',
    },
  },
  {
    'tpope/vim-repeat',
  },
}
