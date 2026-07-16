return {
  {
    'wakatime/vim-wakatime',
    lazy = false,
  },
  {
    'jannis-baum/vivify.vim',
    event = 'BufRead *.md',
    config = function()
      vim.g.vivify_instant_refresh = 1
      vim.g.vivify_filetypes = { 'markdown', 'vimwiki' }
    end,
  },
  {
    'tris203/hawtkeys.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = true,
  },
  {
    'jidn/vim-dbml',
  },
}
